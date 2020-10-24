%{
#include "symbol_table.h"
#include <stdio.h>
extern int yyerror(const char *msg);
extern int yylex(void);
%}

%union
{
	double dval;
	struct st_symbol *symp;
}

%token <symp> NAME
%token <dval> NUMBER
%left '-' '+'
%left '*' '/'
%nonassoc UMINUS

%type <dval> expression

%%

statement_list: statement '\n'
			  | statement_list statement '\n'

statement: NAME '=' expression { $1->val = $3; }
		 | expression          { printf("= %g\n", $1); }

expression: expression '+' expression { $$ = $1 + $3; }
		  | expression '-' expression { $$ = $1 - $3; }
		  | expression '*' expression { $$ = $1 * $3; }
		  | expression '/' expression {
             	if ($3 == 0)
             		yyerror("Divide by zero");
             	else
             		$$ = $1 / $3;
             }
		  | '-' expression %prec UMINUS { $$ = -$2; }
		  | '(' expression ')' { $$ = $2; }
		  | NUMBER
		  | NAME  { $$ = $1->val; }
          ;

%%

extern FILE *yyin;
void *g_syms = NULL;

int main(void)
{
	yyin = stdin;
	while (!feof(yyin))
		yyparse();
	return 0;
}
