#include <assert.h>
#include <stdlib.h>
#include <search.h>
#include <stdio.h>
#include <string.h>

#include "symbol_table.h"

static int
_name_cmp(const void *a, const void* b)
{
	const struct st_symbol *u = a, *v = b;
	return strcmp(u->name, v->name);
}

static int
_always_equal(const void *a, const void *b)
{
	(void) a;
	(void) b;
	return 0;
}

static void _symbol_free(struct st_symbol *y)
{
	assert(y);
	free(y->name);
	free(y);
}

struct st_symbol *st_find(void **tab, const char *s)
{
	struct st_symbol   y   = { .name = (char *)s },
	                 **elt = tfind(&y, tab, _name_cmp);
	return elt ? *elt : NULL;
}

struct st_symbol *st_search(void **tab, const char *s)
{
	struct st_symbol *y, **found;

	if (!(y = malloc(sizeof *y)))
		abort();
	/* zero out all other fields (especially floats)
	 * more portably than calloc */
	*y = (struct st_symbol){.name = strdup(s)};
	if (!y->name)
		abort();
	if (!(found = tsearch(y, tab, _name_cmp)))
		abort();

	if (*found != y) /* already existed */
		_symbol_free(y);
	return *found;
}

void st_free(void **tab)
{
	while (*tab)
	{
		struct st_symbol *item = *(struct st_symbol **)*tab;
		tdelete(item, tab, _always_equal);
		_symbol_free(item);
	}
}
