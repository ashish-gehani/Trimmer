/*
 * The Yices SMT Solver. Copyright 2014 SRI International.
 *
 * This program may only be used subject to the noncommercial end user
 * license agreement which is downloadable along with this program.
 */

/*
 * TEMPLATE FOR GENERATING yices_version.c
 */


/*
 * Visibility control: version strings are part of the API.
 */
#if defined(CYGWIN) || defined(MINGW)
#define EXPORTED __declspec(dllexport)
#else
#define EXPORTED __attribute__((visibility("default")))
#endif


EXPORTED const char * const yices_version = "2.5.2";
EXPORTED const char * const yices_build_date = "2017-11-05";
EXPORTED const char * const yices_build_arch = "x86_64-unknown-linux-gnu";

#if defined(YICES_STATIC)
EXPORTED const char * const yices_build_mode = "release/static";
#else
EXPORTED const char * const yices_build_mode = "release";
#endif

#ifndef NDEBUG
const char * const yices_rev = "a02aec1b58ef17854f07cddc1186f32504135224";
#endif
