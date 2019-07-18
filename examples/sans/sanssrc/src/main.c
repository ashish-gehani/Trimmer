/*
 * main.c
 *
 * Copyright (C) 2014 - 2015, Xiaoxiao <i@xiaoxiao.im>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <assert.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "conf.h"
#include "sans.h"
#include "utils.h"

#ifdef HAVE_CONFIG_H
#  include "config.h"
#endif


/*
 * @func signal_cb()
 * @desc signal callback
 */
static void signal_cb(int signo)
{
    assert((signo == SIGINT) || (signo == SIGTERM));
    sans_stop();
}


/*
 * @func main()
 */
int main(int argc, char **argv)
{
    conf_t conf;

    // parse command line parameters and config file
    if (parse_args(argc, argv, &conf) != 0)
    {
        return EXIT_FAILURE;
    }

    // daemonize
    if (conf.daemon)
    {
        if (daemonize(conf.pidfile, conf.logfile) != 0)
        {
            return EXIT_FAILURE;
        }
    }

    // 注册 signal handle
#ifdef HAVE_SIGACTION
    struct sigaction sa;
    sa.sa_handler = signal_cb;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_RESTART;
    sigaction(SIGINT, &sa, NULL);
    sigaction(SIGTERM, &sa, NULL);
#else
    signal(SIGINT, signal_cb);
    signal(SIGTERM, signal_cb);
#endif

    // initialize
    if (sans_init(&conf) != 0)
    {
        return EXIT_FAILURE;
    }

    // run
    return sans_run();
}
