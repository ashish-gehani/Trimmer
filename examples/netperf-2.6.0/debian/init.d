#!/bin/sh
#
#
# Written by Miquel van Smoorenburg <miquels@cistron.nl>.
# Modified for Debian GNU/Linux by Ian Murdock <imurdock@gnu.org>.
# Modified for Debian by Christoph Lameter <clameter@debian.org>

### BEGIN INIT INFO
# Provides:             netperf
# Required-Start:       $remote_fs $local_fs $time
# Required-Stop:        $remote_fs $local_fs $time
# Should-Start:         $network $named
# Should-Stop:          $network $named
# Default-Start:        2 3 4 5
# Default-Stop:         0 1 6
# Short-Description:    network benchmark
### END INIT INFO

PATH=/bin:/usr/bin:/sbin:/usr/sbin
DAEMON=/usr/bin/netserver

test -f $DAEMON || exit 0


# Read configuration variable file if it is present
[ -r /etc/default/netperf ] && . /etc/default/netperf

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.0-6) to ensure that this file is present.
. /lib/lsb/init-functions

case "$1" in
  start)
	if [ x"NETSERVER_ENABLE" = xno ]
	then
		log_warning_msg "netperf daemon not enabled in /etc/default/netperf, not starting..."
		return 0
	fi
	log_begin_msg "Starting network benchmark server"
	start-stop-daemon --start --quiet --exec $DAEMON < /dev/null > /dev/null 2>&1 
	log_end_msg $?
    ;;
  stop)
	log_begin_msg "Stopping network benchmark server"
	start-stop-daemon --stop --quiet --exec $DAEMON
	log_end_msg $?
    ;;
  #reload)
    #
    # If the daemon can reload its config files on the fly
    # for example by sending it SIGHUP, do it here.
    #
    # If the daemon responds to changes in its config file
    # directly anyway, make this a do-nothing entry.
    #
    # start-stop-daemon --stop --signal 1 --verbose --exec $DAEMON
    # ;;
  restart|force-reload)
  #
  # If the "reload" option is implemented, move the "force-reload"
  # option to the "reload" entry above. If not, "force-reload" is
  # just the same as "restart".
  #
    log_begin_msg "Restarting network benchmark server"
    start-stop-daemon --stop --verbose --exec $DAEMON
    sleep 1
    start-stop-daemon --start --verbose --exec $DAEMON < /dev/null > /dev/null 2>&1
    log_end_msg $?
    ;;
  *)
    echo "Usage: /etc/init.d/netperf {start|stop|restart|force-reload}"
    exit 1
    ;;
esac

exit 0
