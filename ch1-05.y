%{
#include <stdio.h>

extern int yyerror(const char *msg);
extern int yylex(void);
%}

%token NOUN PRONOUN VERB ADVERB ADJECTIVE PREPOSITION CONJUNCTION

%%

sentence: subject VERB object { puts("Valid sentence."); }
	;

subject:	NOUN
	|		PRONOUN
	;

object:		NOUN
	;

%%

extern FILE *yyin;

int main(void)
{
	yyin = stdin;
	while (!feof(yyin))
		yyparse();
	return 0;
}
