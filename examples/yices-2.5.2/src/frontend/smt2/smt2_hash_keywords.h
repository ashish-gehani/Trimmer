/* ANSI-C code produced by gperf version 3.0.3 */
/* Command-line: gperf -C -L ANSI-C -W smt2_kw -H hash_kw -E --output-file=frontend/smt2/smt2_hash_keywords.h --lookup-function-name=in_smt2_kw frontend/smt2/smt2_keywords.txt  */
/* Computed positions: -k'6,10' */

#if !((' ' == 32) && ('!' == 33) && ('"' == 34) && ('#' == 35) \
      && ('%' == 37) && ('&' == 38) && ('\'' == 39) && ('(' == 40) \
      && (')' == 41) && ('*' == 42) && ('+' == 43) && (',' == 44) \
      && ('-' == 45) && ('.' == 46) && ('/' == 47) && ('0' == 48) \
      && ('1' == 49) && ('2' == 50) && ('3' == 51) && ('4' == 52) \
      && ('5' == 53) && ('6' == 54) && ('7' == 55) && ('8' == 56) \
      && ('9' == 57) && (':' == 58) && (';' == 59) && ('<' == 60) \
      && ('=' == 61) && ('>' == 62) && ('?' == 63) && ('A' == 65) \
      && ('B' == 66) && ('C' == 67) && ('D' == 68) && ('E' == 69) \
      && ('F' == 70) && ('G' == 71) && ('H' == 72) && ('I' == 73) \
      && ('J' == 74) && ('K' == 75) && ('L' == 76) && ('M' == 77) \
      && ('N' == 78) && ('O' == 79) && ('P' == 80) && ('Q' == 81) \
      && ('R' == 82) && ('S' == 83) && ('T' == 84) && ('U' == 85) \
      && ('V' == 86) && ('W' == 87) && ('X' == 88) && ('Y' == 89) \
      && ('Z' == 90) && ('[' == 91) && ('\\' == 92) && (']' == 93) \
      && ('^' == 94) && ('_' == 95) && ('a' == 97) && ('b' == 98) \
      && ('c' == 99) && ('d' == 100) && ('e' == 101) && ('f' == 102) \
      && ('g' == 103) && ('h' == 104) && ('i' == 105) && ('j' == 106) \
      && ('k' == 107) && ('l' == 108) && ('m' == 109) && ('n' == 110) \
      && ('o' == 111) && ('p' == 112) && ('q' == 113) && ('r' == 114) \
      && ('s' == 115) && ('t' == 116) && ('u' == 117) && ('v' == 118) \
      && ('w' == 119) && ('x' == 120) && ('y' == 121) && ('z' == 122) \
      && ('{' == 123) && ('|' == 124) && ('}' == 125) && ('~' == 126))
/* The character set is not based on ISO-646.  */
#error "gperf generated tables don't work with this execution character set. Please report a bug to <bug-gnu-gperf@gnu.org>."
#endif

#line 1 "frontend/smt2/smt2_keywords.txt"

#include <string.h>
#include "frontend/smt2/smt2_lexer.h"
#line 7 "frontend/smt2/smt2_keywords.txt"
struct keyword_s;
/* maximum key range = 41, duplicates = 0 */

#ifdef __GNUC__
__inline
#else
#ifdef __cplusplus
inline
#endif
#endif
static unsigned int
hash_kw (register const char *str, register unsigned int len)
{
  static const unsigned char asso_values[] =
    {
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 15, 46,  5,
       0,  0, 46,  0,  8, 10, 46, 46,  5, 30,
       5,  5, 25, 46,  0,  5,  0,  0,  5, 46,
      46,  0, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
      46, 46, 46, 46, 46, 46
    };
  register int hval = len;

  switch (hval)
    {
      default:
        hval += asso_values[(unsigned char)str[9]];
      /*FALLTHROUGH*/
      case 9:
      case 8:
      case 7:
      case 6:
        hval += asso_values[(unsigned char)str[5]];
      /*FALLTHROUGH*/
      case 5:
        break;
    }
  return hval;
}

#ifdef __GNUC__
__inline
#ifdef __GNUC_STDC_INLINE__
__attribute__ ((__gnu_inline__))
#endif
#endif
const struct keyword_s *
in_smt2_kw (register const char *str, register unsigned int len)
{
  enum
    {
      TOTAL_KEYWORDS = 26,
      MIN_WORD_LENGTH = 5,
      MAX_WORD_LENGTH = 26,
      MIN_HASH_VALUE = 5,
      MAX_HASH_VALUE = 45
    };

  static const struct keyword_s smt2_kw[] =
    {
      {""}, {""}, {""}, {""}, {""},
#line 21 "frontend/smt2/smt2_keywords.txt"
      {":name",                        SMT2_KW_NAME},
#line 26 "frontend/smt2/smt2_keywords.txt"
      {":named",                       SMT2_KW_NAMED},
#line 28 "frontend/smt2/smt2_keywords.txt"
      {":status",                      SMT2_KW_STATUS},
#line 27 "frontend/smt2/smt2_keywords.txt"
      {":pattern",                     SMT2_KW_PATTERN},
#line 31 "frontend/smt2/smt2_keywords.txt"
      {":category",                    SMT2_KW_CATEGORY},
      {""},
#line 33 "frontend/smt2/smt2_keywords.txt"
      {":notes",                       SMT2_KW_NOTES},
#line 29 "frontend/smt2/smt2_keywords.txt"
      {":source",                      SMT2_KW_SOURCE},
#line 22 "frontend/smt2/smt2_keywords.txt"
      {":authors",                     SMT2_KW_AUTHORS},
      {""},
#line 19 "frontend/smt2/smt2_keywords.txt"
      {":verbosity",                   SMT2_KW_VERBOSITY},
      {""},
#line 18 "frontend/smt2/smt2_keywords.txt"
      {":random-seed",                 SMT2_KW_RANDOM_SEED},
#line 23 "frontend/smt2/smt2_keywords.txt"
      {":version",                     SMT2_KW_VERSION},
#line 9 "frontend/smt2/smt2_keywords.txt"
      {":print-success",               SMT2_KW_PRINT_SUCCESS},
#line 13 "frontend/smt2/smt2_keywords.txt"
      {":produce-unsat-cores",         SMT2_KW_PRODUCE_UNSAT_CORES},
#line 32 "frontend/smt2/smt2_keywords.txt"
      {":difficulty",                  SMT2_KW_DIFFICULTY},
      {""},
#line 20 "frontend/smt2/smt2_keywords.txt"
      {":error-behavior",              SMT2_KW_ERROR_BEHAVIOR},
#line 10 "frontend/smt2/smt2_keywords.txt"
      {":expand-definitions",          SMT2_KW_EXPAND_DEFINITIONS},
#line 24 "frontend/smt2/smt2_keywords.txt"
      {":reason-unknown",              SMT2_KW_REASON_UNKNOWN},
#line 30 "frontend/smt2/smt2_keywords.txt"
      {":smt-lib-version",             SMT2_KW_SMT_LIB_VERSION},
#line 11 "frontend/smt2/smt2_keywords.txt"
      {":interactive-mode",            SMT2_KW_INTERACTIVE_MODE},
#line 34 "frontend/smt2/smt2_keywords.txt"
      {":global-decls",                SMT2_KW_GLOBAL_DECLS},
      {""},
#line 25 "frontend/smt2/smt2_keywords.txt"
      {":all-statistics",              SMT2_KW_ALL_STATISTICS},
      {""}, {""},
#line 16 "frontend/smt2/smt2_keywords.txt"
      {":regular-output-channel",      SMT2_KW_REGULAR_OUTPUT},
      {""},
#line 15 "frontend/smt2/smt2_keywords.txt"
      {":produce-assignments",         SMT2_KW_PRODUCE_ASSIGNMENTS},
      {""}, {""}, {""}, {""},
#line 12 "frontend/smt2/smt2_keywords.txt"
      {":produce-proofs",              SMT2_KW_PRODUCE_PROOFS},
#line 17 "frontend/smt2/smt2_keywords.txt"
      {":diagnostic-output-channel",   SMT2_KW_DIAGNOSTIC_OUTPUT},
      {""}, {""}, {""},
#line 14 "frontend/smt2/smt2_keywords.txt"
      {":produce-models",              SMT2_KW_PRODUCE_MODELS}
    };

  if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
    {
      register int key = hash_kw (str, len);

      if (key <= MAX_HASH_VALUE && key >= 0)
        {
          register const char *s = smt2_kw[key].word;

          if (*str == *s && !strcmp (str + 1, s + 1))
            return &smt2_kw[key];
        }
    }
  return 0;
}
