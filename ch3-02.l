%option nounput noinput

%{
#include <stdlib.h>
#include <limits.h>

#include "ch3-02.tab.h"

extern int yyerror(const char *msg);
extern int yylval;
%}

%%

[0-9]+ {
	long n = strtol(yytext, NULL, 10);
	if (n < INT_MIN || n > INT_MAX)
		yyerror("Number out of range");
	yylval = (int)n;
	return NUMBER;
}

[ \t]  ;
\n     { return 0; }
.      { return *yytext; }

%%
