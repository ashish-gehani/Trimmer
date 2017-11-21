#!/bin/sh
#
# mini_httpd.sh - startup script for mini_httpd on FreeBSD
#
# This should be manually installed as:
#  /usr/local/etc/rc.d/mini_httpd
# It gets run at boot-time.
#
# Variables available:
#   mini_httpd_enable='YES'
#   mini_httpd_program='/usr/local/sbin/mini_httpd'
#   mini_httpd_pidfile='/var/run/mini_httpd.pid'
#   mini_httpd_devfs=...
#   mini_httpd_flags=...
#
# PROVIDE: mini_httpd
# REQUIRE: LOGIN FILESYSTEMS
# KEYWORD: shutdown

. /etc/rc.subr

name='mini_httpd'
rcvar='mini_httpd_enable'
start_precmd='mini_httpd_precmd'
mini_httpd_enable_defval='NO'

load_rc_config "$name"
command="${mini_httpd_program:-/usr/local/sbin/${name}}"
pidfile="${mini_httpd_pidfile:-/var/run/${name}.pid}"
command_args="-i ${pidfile}"

mini_httpd_precmd ()
{
	if [ -n "$mini_httpd_devfs" ] ; then
		mount -t devfs devfs "$mini_httpd_devfs"
		devfs -m "$mini_httpd_devfs" rule -s 1 applyset
		devfs -m "$mini_httpd_devfs" rule -s 2 applyset
	fi
}

run_rc_command "$1"
