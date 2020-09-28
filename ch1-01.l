%option nounput noinput
%%
.|\n	ECHO;
%%

int main(void)
{
	yylex();
	return 0;
}
