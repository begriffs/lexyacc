#ifndef LEXYACC_SYMBOL_TABLE_H
#define LEXYACC_SYMBOL_TABLE_H

#include <stdbool.h>

struct st_symbol
{
	char *name;
	int type;
	double val;
};

struct st_symbol*
st_lookup(void **tab, const char *s);
bool st_add(void **tab, const char *s, int type, double val);
void st_free(void **tab);

#endif
