#!/bin/sh
# Copyright (c) 2015 Dmitry V. Levin <ldv@altlinux.org>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. The name of the author may not be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

set -efu

# This script processes header files containing ioctl command definitions in
# symbolic form, assuming that these definitions match the following regular
# expressions:

r_define='^[[:space:]]*#[[:space:]]*define[[:space:]]\+'
r_cmd_name='[A-Z][A-Z0-9_]*'
r_io='\([A-Z]\+\)\?_S\?\(IO\|IOW\|IOR\|IOWR\|IOC\)'
r_value='[[:space:]]\+'"$r_io"'[[:space:]]*([^)]'
regexp="${r_define}${r_cmd_name}${r_value}"

me="${0##*/}"
msg()
{
	printf >&2 '%s\n' "$me: $*"
}

prefix=
case $# in
	1)	inc_dir="$1"; shift
		;;
	2)	inc_dir="$1"; shift
		prefix="$1"; shift
		;;
	*)	echo >&2 "usage: $me include-directory [prefix]"
		exit 1
		;;
esac

[ -z "$prefix" ] ||
	prefix="${prefix%%/}/"

tmpdir=
cleanup()
{
	trap - EXIT
	[ -z "$tmpdir" ] ||
		rm -rf -- "$tmpdir"
	exit "$@"
}

trap 'cleanup $?' EXIT
trap 'cleanup 1' HUP PIPE INT QUIT TERM
tmpdir="$(mktemp -dt "$me.XXXXXX")"

# list interesting files in $inc_dir.
cd "$inc_dir"
inc_dir="$(pwd -P)"
find . -type f -name '*.h' -print0 |
	xargs -r0 grep -l "$r_value" -- > "$tmpdir"/headers1.list ||
		exit 0
cd - > /dev/null
sed 's|^\./\(uapi/\)\?||' < "$tmpdir"/headers1.list > "$tmpdir"/headers.list
LC_COLLATE=C sort -u -o "$tmpdir"/headers.list "$tmpdir"/headers.list

msg "processing $(wc -l < "$tmpdir"/headers.list) header files from $inc_dir"
failed=0

CC="${CC:-gcc}"
CPP="${CPP:-cpp}"
CPPFLAGS="${CPPFLAGS-} -D__EXPORTED_HEADERS__"
CFLAGS="${CFLAGS:--Wall -O2} -D__EXPORTED_HEADERS__"
LDFLAGS="${LDFLAGS-}"
INCLUDES="-I$inc_dir/uapi -I$inc_dir ${INCLUDES-}"

$CC $INCLUDES $CFLAGS -c -o "$tmpdir"/print_ioctlent.o "${0%/*}"/print_ioctlent.c

# Hook onto <asm-generic/ioctl.h> and <asm/ioctl.h>
for d in asm-generic asm; do
	mkdir "$tmpdir/$d"
	cat > "$tmpdir/$d"/ioctl.h <<__EOF__
#include_next <$d/ioctl.h>
#undef _IOC
#define _IOC(dir,type,nr,size) dir, type, nr, size
__EOF__
done

INCLUDES="-I$tmpdir $INCLUDES"

process_file()
{
	local f="$1"; shift

	# Common code for every processed file.
	cat > "$tmpdir"/printents.c <<__EOF__
#include <asm/termbits.h>
#include <asm/ioctl.h>
#include <linux/types.h>
#include <linux/limits.h>
#include <linux/major.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <stdint.h>
#include <stdbool.h>

#ifndef NULL
# define NULL ((void*)0)
#endif
#ifndef __user
# define __user
#endif
#ifndef __iomem
# define __iomem
#endif
#ifndef __noreturn
# define __noreturn __attribute__((noreturn))
#endif
#ifndef __packed
# define __packed __attribute__((packed))
#endif

typedef signed char s8;
typedef unsigned char u8;
typedef signed short s16;
typedef unsigned short u16;
typedef signed int s32;
typedef unsigned int u32;
typedef signed long long s64;
typedef unsigned long long u64;

#include "fixes.h"

#include <asm/bitsperlong.h>
#ifndef BITS_PER_LONG
# define BITS_PER_LONG __BITS_PER_LONG
#endif

#include "$f"

void print_ioctlent(const char *, const char *, unsigned short, unsigned short, unsigned short, unsigned short);

int main(void)
{

#include "defs.h"

return 0;
}
__EOF__

	# Soft workarounds for some processed files.  Fragile.
	case "$f" in
		*asm/cmb.h)
			echo '#include <asm/dasd.h>'
			;;
		*asm/ioctls.h)
			cat <<'__EOF__'
#include <asm/termios.h>
#include <linux/serial.h>
__EOF__
			;;
		*drm/*_drm.h)
			echo '#include <drm/drm.h>'
			;;
		fbio.h|*/fbio.h)
			cat <<'__EOF__'
#include <linux/fb.h>
#undef FBIOGETCMAP
#undef FBIOPUTCMAP
__EOF__
			;;
		*linux/atm?*.h)
			echo '#include <linux/atm.h>'
			;;
		*linux/auto_fs*.h)
			echo 'typedef u32 compat_ulong_t;'
			;;
		*linux/btrfs.h)
			cat <<'__EOF__'
struct btrfs_ioctl_defrag_range_args { __u32 unused[12]; };
#define BTRFS_LABEL_SIZE 256
__EOF__
			;;
		*linux/coda.h|*android_alarm.h)
			cat <<'__EOF__'
#ifndef _LINUX_TIME_H
# define _LINUX_TIME_H
#endif
#ifndef _UAPI_LINUX_TIME_H
# define _UAPI_LINUX_TIME_H
#endif
__EOF__
			;;
		*linux/fs.h|*linux/ncp_fs.h)
			cat <<'__EOF__'
#include <linux/blktrace_api.h>
#include <linux/fiemap.h>
__EOF__
			;;
		*linux/if_pppox.h)
			cat <<'__EOF__'
#include <linux/if.h>
#include <linux/in.h>
#include <linux/in6.h>
__EOF__
			;;
		*linux/if_tun.h|*linux/ppp-ioctl.h)
			echo '#include <linux/filter.h>'
			;;
		*linux/isdn_ppp.h|*linux/gsmmux.h)
			echo '#include <linux/if.h>'
			;;
		*media/saa6588.h)
			echo 'typedef struct poll_table_struct poll_table;'
			;;
		*linux/ivtvfb.h|*linux/meye.h|*media/*.h)
			echo '#include <linux/videodev2.h>'
			;;
		*linux/kvm.h)
			cat <<'__EOF__'
#if defined __x86_64__ || defined __i386__
struct kvm_allocate_rma { __u32 unused[2]; };
struct kvm_create_spapr_tce { __u32 unused[3]; };
struct kvm_get_htab_fd { __u32 unused[8]; };
struct kvm_rtas_token_args { __u8 unused[128]; };
struct kvm_vcpu_init { __u32 unused[8]; };
#elif defined __arm64__ || defined __arm__
struct kvm_allocate_rma { __u32 unused[2]; };
struct kvm_cpuid { __u32 unused[2]; };
struct kvm_cpuid2 { __u32 unused[2]; };
struct kvm_create_spapr_tce { __u32 unused[3]; };
struct kvm_debugregs { __u32 unused[32]; };
struct kvm_get_htab_fd { __u32 unused[8]; };
struct kvm_lapic_state { __u32 unused[256]; };
struct kvm_memory_alias { __u32 unused[8]; };
struct kvm_msr_list { __u32 unused[1]; };
struct kvm_msrs { __u32 unused[2]; };
struct kvm_pit_state { __u32 unused[18]; };
struct kvm_pit_state2 { __u32 unused[28]; };
struct kvm_rtas_token_args { __u32 unused[128]; };
struct kvm_vcpu_events { __u32 unused[16]; };
struct kvm_x86_mce { __u32 unused[16]; };
struct kvm_xcrs { __u32 unused[98]; };
struct kvm_xen_hvm_config { __u32 unused[14]; };
struct kvm_xsave { __u32 unused[1024]; };
#endif
__EOF__
			;;
		*linux/sonet.h)
			echo '#include <linux/atmioc.h>'
			;;
		*linux/usbdevice_fs.h)
			cat <<'__EOF__'
struct usbdevfs_ctrltransfer32 { __u32 unused[4]; };
struct usbdevfs_bulktransfer32 { __u32 unused[4]; };
struct usbdevfs_disconnectsignal32 { __u32 unused[2]; };
struct usbdevfs_urb32 { __u8 unused[42]; };
struct usbdevfs_ioctl32 { __u32 unused[3]; };
__EOF__
			;;
		logger.h|*/logger.h)
			echo 'typedef __u32 kuid_t;'
			;;
		*sound/asequencer.h)
			cat <<'__EOF__'
#include <sound/asound.h>
struct snd_seq_queue_owner { __u32 unused[0]; };
__EOF__
			;;
		*sound/emu10k1.h)
			cat <<'__EOF__'
#include <sound/asound.h>
#ifndef DECLARE_BITMAP
# define DIV_ROUND_UP(x,y) (((x) + ((y) - 1)) / (y))
# define BITS_TO_LONGS(nr) DIV_ROUND_UP(nr, 8 * sizeof(long))
# define DECLARE_BITMAP(name,bits) unsigned long name[BITS_TO_LONGS(bits)]
#endif
__EOF__
			;;
		*video/sstfb.h)
			echo 'struct fb_info;'
			;;
		*xen/interface/*.h)
			return 0 # false positives
			;;
		*xen/privcmd.h)
			return 0 # too much work to make it compileable
			;;
	esac > "$tmpdir"/fixes.h

	cat > "$tmpdir"/header.in <<__EOF__
#include <asm/bitsperlong.h>
#ifndef BITS_PER_LONG
# define BITS_PER_LONG __BITS_PER_LONG
#endif
#include "$f"
__EOF__

	if [ -f "$inc_dir/uapi/$f" ]; then
		s="$inc_dir/uapi/$f"
	elif [ -f "$inc_dir/$f" ]; then
		s="$inc_dir/$f"
	else
		msg "$f: file not found"
		return 1
	fi

	[ -n "${f##*/*}" ] ||
		mkdir -p "$tmpdir/${f%/*}"
	# Hard workarounds for some processed files.  Very fragile.
	case "$f" in
		*acpi/*|*linux/i2o.h|*media/exynos-fimc.h|*media/v4l2-subdev.h|*net/bluetooth/*)
			# Fetch macros only.
			grep "${r_define}${r_cmd_name}" < "$s" > "$tmpdir/$f"
			;;
		binder.h|*/binder.h)
			# Convert enums to macros.
			sed '/^enum binder/,/^};/d' < "$s" > "$tmpdir/$f"
			sed -n '/^enum binder/,/^};/ s/^[[:space:]].*/&/p' < "$s" |
			sed -e '
s/^[[:space:]]*\([A-Z][A-Z_0-9]*\)[[:space:]]*=[[:space:]]*_\(IO\|IOW\|IOR\|IOWR\|IOC\)[[:space:]]*(/#define \1 _\2(/
s/^\(#define .*)\),$/\1/
s/^\(#define .*,\)$/\1 \\/
s/^\([[:space:]]\+[^),]\+)\),$/\1/' >> "$tmpdir/$f"
			;;
		*drm/r128_drm.h)
			# Filter out the code that references unknown types.
			sed '/drm_r128_clear2_t/d' < "$s" > "$tmpdir/$f"
			;;
		*drm/sis_drm.h)
			# Filter out the code that references unknown types.
			sed '/^struct sis_file_private/,/^}/d' < "$s" > "$tmpdir/$f"
			;;
		*drm/via_drm.h)
			# Create the file it attempts to include.
			touch "$tmpdir/via_drmclient.h"
			# Filter out the code that references unknown types.
			sed '/^struct via_file_private/,/^}/d' < "$s" > "$tmpdir/$f"
			;;
		*linux/vmw_vmci_defs.h)
			# Fetch ioctl macros only.
			grep "${r_define}I" < "$s" > "$tmpdir/$f"
			;;
		*media/v4l2-common.h)
			# Fetch one piece of code containing ioctls definitions.
			sed -n '/ remaining ioctls/,/ ---/p' < "$s" > "$tmpdir/$f"
			;;
		*linux/nilfs2_fs.h)
			# Create the file it attempts to include.
			touch "$tmpdir/asm/bug.h"
			;;
		openpromio.h|*/openpromio.h|fbio.h|*/fbio.h)
			# Create the file it attempts to include.
			mkdir -p "$tmpdir/linux"
			touch "$tmpdir/linux/compiler.h"
	esac
	if [ -f "$tmpdir/$f" ]; then
		s="$tmpdir/$f"
	fi

	# This may fail if the file includes unavailable headers.
	# In case of success it outputs both the #define directives
	# and the result of preprocessing.
	$CPP $CPPFLAGS -dD $INCLUDES < "$tmpdir"/header.in > "$tmpdir"/header.out

	# Need to exclude ioctl commands defined elsewhere.
	local_defines='^[[:space:]]*#[[:space:]]*define[[:space:]]\+\('"$r_cmd_name"'\)[[:space:]]'
	sed -n 's/'"$local_defines"'.*/\1\\/p' "$s" > "$tmpdir"/local_names
	r_local_names="$(tr '\n' '|' < "$tmpdir"/local_names)"
	r_local_names="${r_local_names%%|}"
	r_local_names="${r_local_names%%\\}"

	# Keep this in sync with $regexp by replacing $r_cmd_name with $r_local_names.
	defs_regexp="${r_define}\($r_local_names\)${r_value}"

	qf="$(echo "$prefix$f" | sed 's/[&\/]/\\&/g')"
	# This outputs lines in the following format:
	# print_ioctlent("filename.h", "IOCTL_CMD_NAME", IOCTL_CMD_NAME);
	sed -n 's/'"$defs_regexp"'.*/print_ioctlent("'"$qf"'", "\1", \1);/p' \
		< "$tmpdir"/header.out > "$tmpdir"/defs.h

	# If something is wrong with the file, this will fail.
	$CC $INCLUDES $CFLAGS -c -o "$tmpdir"/printents.o "$tmpdir"/printents.c
	$CC $LDFLAGS -o "$tmpdir"/print_ioctlents \
		"$tmpdir"/printents.o "$tmpdir"/print_ioctlent.o
	"$tmpdir"/print_ioctlents > "$tmpdir"/ioctlents
	cat "$tmpdir"/ioctlents
	msg "$f: fetched $(grep -c '^{' "$tmpdir"/ioctlents) ioctl entries"
}

while read f; do
	(process_file "$f" < /dev/null)
	[ $? -eq 0 ] || {
		msg "$f: failed to process"
		failed=$((1 + $failed))
	}
done < "$tmpdir"/headers.list

[ $failed -eq 0 ] ||
	msg "failed to process $failed file(s)"
