%option nounput noinput
%{
#include "ch1-lex-vs-c.h"
%}

%%

[ \t]+					;

[0-9]+					|
[0-9]+\.[0-9]+			|
\.[0-9]+				{ return NUMBER; }

#.*						{ return COMMENT; }
\"[^"\n]*\"				{ return TEXT; }
[a-zA-Z][a-zA-Z0-9]+	{ return COMMAND; }
\n						{ return '\n'; }

%%

#include <stdio.h>

int main(void)
{
	int val;
	while ((val = yylex()) != 0)
		printf("Got %d\n", val);
	return 0;
}
