#
#  knock
#
#  Copyright (c) 2004 by Judd Vinet <jvinet@zeroflux.org>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, 
#  USA.
#

DESTDIR =
prefix = /usr/local
exec_prefix = /usr/local

VERSION = 0.5

BINDIR  = ${exec_prefix}/bin
SBINDIR = ${exec_prefix}/sbin
MANDIR  = ${prefix}/man

INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL} $(AM_INSTALL_PROGRAM_FLAGS)
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_SCRIPT = ${INSTALL}

TOPDIR = .
SRCDIR = $(TOPDIR)/src/
OBJDIR = $(TOPDIR)/src/
MANSRC = $(TOPDIR)/doc/

CXX = wllvm
CXXFLAGS += -Xclang -disable-O0-optnone -Wall -pedantic -fno-exceptions -Xclang -disable-O0-optnone \
            -D_GNU_SOURCE -I.
LDFLAGS += 

SRCS = $(SRCDIR)knockd.c \
			 $(SRCDIR)knock.c \
			 $(SRCDIR)list.c

all: knockd knock man

knockd: $(OBJDIR)knockd.o $(OBJDIR)list.o
	$(CXX) $(OBJDIR)knockd.o $(OBJDIR)list.o -o $@ $(LDFLAGS) -lpcap

knock: $(OBJDIR)knock.o
	$(CXX) $(OBJDIR)knock.o -o $@ $(LDFLAGS)

.c.o: $(SRCS)
	$(CXX) $(CXXFLAGS) -o $@ -c $<

man: $(MANSRC)knockd.1 $(MANSRC)knock.1

%.1: %.1.in
	sed -e "s/#VERSION#/$(VERSION)/" $< > $@

dist: distclean
	(cd ..; tar czvf knock-$(VERSION).tar.gz knock-$(VERSION))

install: all
	$(INSTALL) -D -m0755 knockd $(DESTDIR)$(SBINDIR)/knockd
	$(INSTALL) -D -m0755 knock $(DESTDIR)$(BINDIR)/knock
	$(INSTALL) -D -m0644 $(MANSRC)knockd.1 $(DESTDIR)$(MANDIR)/man1/knockd.1
	$(INSTALL) -D -m0644 $(MANSRC)knock.1 $(DESTDIR)$(MANDIR)/man1/knock.1
	$(INSTALL) -D -m0644 knockd.conf $(DESTDIR)/etc/knockd.conf

clean:
	rm -f *~ $(OBJDIR)*.o $(MANSRC)*.1

distclean: clean
	rm -f knockd knock
	rm -f Makefile
	rm -f config.h config.status config.log

# End of file
