#ifndef LEXYACC_SYMBOL_TABLE_H
#define LEXYACC_SYMBOL_TABLE_H

struct st_symbol
{
	char *name;
	int type;
	double val;
};

struct st_symbol *st_find(void **tab, const char *s);
struct st_symbol *st_search(void **tab, const char *s);
void st_free(void **tab);

#endif
