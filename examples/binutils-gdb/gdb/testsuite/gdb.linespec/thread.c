/* This testcase is part of GDB, the GNU debugger.

   Copyright 2012-2017 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* http://sourceware.org/bugzilla/show_bug.cgi?id=14643 */

static void
thread ()
{
}

int
main ()
{
  int x = 0;
  thread (); /* set breakpoint 1 here */
  return x;
}
