/*
 * conf.h - parse config
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

#ifndef CONF_H
#define CONF_H


/*
* @type conf_t
* @desc configuration
*/
typedef struct
{
    int verbose;
    int nspresolver;
    int daemon;
    char user[16];
    char pidfile[64];
    char logfile[64];
    struct
    {
        char addr[64];
        char port[16];
    } listen, socks5, test_server, cn_server, server;
} conf_t;


/*
* @func parse_args()
* @desc parse command line parameters
*/
extern int parse_args(int argc, char **argv, conf_t *conf);


#endif // CONF_H
