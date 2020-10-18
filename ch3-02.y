%{
#include <stdio.h>
extern int yyerror(const char *msg);
extern int yylex(void);
%}

%token NAME NUMBER
%left '-' '+'
%left '*' '/'
%nonassoc UMINUS

%%

statement: NAME '=' expression
		 | expression { printf("= %d\n", $1); }

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
		  | NUMBER { $$ = $1; }
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
