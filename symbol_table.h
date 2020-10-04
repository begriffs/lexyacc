#ifndef LEXYACC_SYMBOL_TABLE_H
#define LEXYACC_SYMBOL_TABLE_H

#include <stdbool.h>

#define ST_UNKNOWN 0

struct st_symbol
{
	char *name;
	int type;
};

int  st_lookup(void **tab, const char *s);
bool st_add(void **tab, const char *s, int type);
void st_free(void **tab);

#endif
