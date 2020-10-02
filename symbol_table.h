#ifndef LEXYACC_SYMBOL_TABLE_H
#define LEXYACC_SYMBOL_TABLE_H

#include <stdbool.h>

#define ST_UNKNOWN 0

struct st_symbol
{
	char *name;
	int type;
};

int  st_lookup(struct st_symbol **tab, const char *s);
bool st_add(struct st_symbol **tab, const char *s, int type);
void st_free(struct st_symbol **tab);

#endif
