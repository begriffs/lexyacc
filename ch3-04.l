%option nounput noinput

%{
#include <errno.h>
#include <stdlib.h>

#include "ch3-04.tab.h"
#include "symbol_table.h"

extern int yyerror(const char *msg);
extern void *g_syms; /* defined in ch3-04.y */
%}

%%

([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) {
	errno = 0;
	yylval.dval = strtod(yytext, NULL);
	if (errno == ERANGE)
		yyerror("Number out of range, or underflow");
	if (errno == EINVAL)
		yyerror("Unable to convert string to number");
	return NUMBER;
}

[ \t]  ;

[A-Za-z][A-Za-z0-9]* {
	yylval.symp = st_search(&g_syms, yytext);
	return NAME;
}

\n     |
.      { return *yytext; }

%%
