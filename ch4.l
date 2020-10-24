%option nounput noinput

%{
#include <string.h>

#include "ch4.tab.h"

long g_lineno = 1;
%}

ws		[ \t]+
qstring	\"[^\"\n]*[\"\n]
nl		\n

%%

{ws}      ;
{qstring} {
	yylval.string = strdup(yytext+1); /* skip initial quote */
	if (yylval.string[yyleng-2] != '"')
		fprintf(stderr,
			"Unterminated character string "
			"(line %ld)\n", g_lineno);
	else
		yylval.string[yyleng-2] = ' '; /* remove close quote */
	return QSTRING;
}
action  { return ACTION; }
execute { return EXECUTE; }
command { return COMMAND; }
ignore  { return IGNORE; }
{nl}    { g_lineno++; }
.       { return *yytext; }
