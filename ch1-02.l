%option nounput noinput
%%
[\t ]+	/* ignore */;

is |
am |
are |
were |
was |
be |
being |
been |
do |
does |
did |
will |
would |
should |
can |
could |
has |
have |
had |
go			{ printf("%s: is a verb\n", yytext); }

[a-zA-Z]+	{ printf("%s: NOT a verb\n", yytext); }

.|\n		{ ECHO; }

%%

int main(void)
{
	yylex();
	return 0;
}
