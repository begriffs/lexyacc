#include <assert.h>
#include <stdlib.h>
#include <search.h>
#include <stdio.h>
#include <string.h>

#include "symbol_table.h"

static int
name_cmp(const void *a, const void* b)
{
	const struct st_symbol *u = a, *v = b;
	return strcmp(u->name, v->name);
}

int st_lookup(void **tab, const char *s)
{
	struct st_symbol   y   = { .name = (char *)s },
	                 **elt = tfind(&y, tab, name_cmp);
	return elt ? (*elt)->type : ST_UNKNOWN;
}

bool st_add(void **tab, const char *s, int type)
{
	assert(type != ST_UNKNOWN);

	struct st_symbol *y = malloc(sizeof *y);
	if (!y) abort();
	y->name = strdup(s);
	y->type = type;
	if (!y->name) abort();

	struct st_symbol **node = tsearch(y, tab, name_cmp);
	if (!node)
		abort();
	else if (*node != y)
	{
		free(y->name); free(y);
		printf("WARNING: name %s already defined\n", s);
		return false;
	}
	return true;
}

static int
always_equal(const void *a, const void *b)
{
	(void) a;
	(void) b;
	return 0;
}

void st_free(void **tab)
{
	while (*tab)
	{
		struct st_symbol *item = *(struct st_symbol **)*tab;
		tdelete(item, tab, always_equal);
		free(item->name);
		free(item);
	}
}
