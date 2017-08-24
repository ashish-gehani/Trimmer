#ifndef ARRAY_H
#define ARRAY_H
#include "first.h"

#ifdef HAVE_PCRE_H
# include <pcre.h>
#endif

#include "buffer.h"
#include "vector.h"

#include <stdlib.h>


// NOTE-HASHIM - important type definitions for data_unset, data_string
#define DATA_IS_STRING(x) (x->type == TYPE_STRING)

typedef enum { TYPE_UNSET, TYPE_STRING, TYPE_OTHER, TYPE_ARRAY, TYPE_INTEGER, TYPE_FASTCGI, TYPE_CONFIG } data_type_t;
#define DATA_UNSET \
	data_type_t type; \
	buffer *key; \
	int is_index_key; /* 1 if key is a array index (autogenerated keys) */ \
	struct data_unset *(*copy)(const struct data_unset *src); \
	void (* free)(struct data_unset *p); \
	void (* reset)(struct data_unset *p); \
	int (*insert_dup)(struct data_unset *dst, struct data_unset *src); \
	void (*print)(const struct data_unset *p, int depth)

typedef struct data_unset {
	DATA_UNSET;
} data_unset;

typedef struct {
	data_unset  **data;

	size_t *sorted;

	size_t used; /* <= SSIZE_MAX */
	size_t size;

	size_t unique_ndx;
} array;

typedef struct {
	DATA_UNSET;

	buffer *value;
} data_string;

data_string *data_string_init(void);
data_string *data_response_init(void);

typedef struct {
	DATA_UNSET;

	array *value;
} data_array;

data_array *data_array_init(void);

/**
 * possible compare ops in the configfile parser
 */
typedef enum {
	CONFIG_COND_UNSET,
	CONFIG_COND_EQ,      /** == */
	CONFIG_COND_MATCH,   /** =~ */
	CONFIG_COND_NE,      /** != */
	CONFIG_COND_NOMATCH, /** !~ */
	CONFIG_COND_ELSE     /** (always true if reached) */
} config_cond_t;

/**
 * possible fields to match against
 */
typedef enum {
	COMP_UNSET,
	COMP_SERVER_SOCKET,
	COMP_HTTP_URL,
	COMP_HTTP_HOST,
	COMP_HTTP_REFERER,
	COMP_HTTP_USER_AGENT,
	COMP_HTTP_LANGUAGE,
	COMP_HTTP_COOKIE,
	COMP_HTTP_REMOTE_IP,
	COMP_HTTP_QUERY_STRING,
	COMP_HTTP_SCHEME,
	COMP_HTTP_REQUEST_METHOD,

	COMP_LAST_ELEMENT
} comp_key_t;

/* $HTTP["host"] ==    "incremental.home.kneschke.de" { ... }
 * for print:   comp_key      op    string
 * for compare: comp          cond  string/regex
 */

typedef struct data_config data_config;
DEFINE_TYPED_VECTOR_NO_RELEASE(config_weak, data_config*);

struct data_config {
	DATA_UNSET;

	array *value;

	buffer *comp_key;
	comp_key_t comp;

	config_cond_t cond;
	buffer *op;

	int context_ndx; /* more or less like an id */
	vector_config_weak children;
	/* nested */
	data_config *parent;
	/* for chaining only */
	data_config *prev;
	data_config *next;

	buffer *string;
#ifdef HAVE_PCRE_H
	pcre   *regex;
	pcre_extra *regex_study;
#endif
};

data_config *data_config_init(void);

typedef struct {
	DATA_UNSET;

	int value;
} data_integer;

data_integer *data_integer_init(void);

typedef struct {
	DATA_UNSET;

	buffer *host;

	unsigned short port;

	time_t disable_ts;
	int is_disabled;
	size_t balance;

	int usage; /* fair-balancing needs the no. of connections active on this host */
	int last_used_ndx; /* round robin */
} data_fastcgi;

data_fastcgi *data_fastcgi_init(void);

array *array_init(void);
array *array_init_array(array *a);
void array_free(array *a);
void array_reset(array *a);
void array_insert_unique(array *a, data_unset *entry);
data_unset *array_pop(array *a); /* only works on "simple" lists with autogenerated keys */
int array_print(array *a, int depth);
data_unset *array_get_unused_element(array *a, data_type_t t);
data_unset *array_get_element(array *a, const char *key);
data_unset *array_extract_element(array *a, const char *key); /* removes found entry from array */
void array_set_key_value(array *hdrs, const char *key, size_t key_len, const char *value, size_t val_len);
void array_replace(array *a, data_unset *entry);
int array_strcasecmp(const char *a, size_t a_len, const char *b, size_t b_len);
void array_print_indent(int depth);
size_t array_get_max_key_length(array *a);

#endif
