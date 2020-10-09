#include <ctype.h>
#include <stdio.h>

#include "ch1-lex-vs-c.h"

int lexer(void)
{
	int c;
	while ((c = getchar()) == ' ' || c == '\t')
		;
	if (c == EOF)
		return 0;

	if (c == '.' || isdigit(c))
	{
		while ((c = getchar()) != EOF && isdigit(c))
			;
		if (c == '.')
			while ((c = getchar()) != EOF && isdigit(c))
				;
		ungetc(c, stdin);
		return NUMBER;
	}

	if (c == '#')
	{
		while ((c = getchar()) != EOF && c != '\n')
			;
		ungetc(c, stdin);
		return COMMENT;
	}

	if (c == '"')
	{
		while ((c = getchar()) != EOF && c != '"' && c != '\n')
			;
		if (c == '\n')
			ungetc(c, stdin);
		return TEXT;
	}

	if (isalpha(c))
	{
		while ((c = getchar()) != EOF && isalnum(c))
			;
		ungetc(c, stdin);
		return COMMAND;
	}

	return c;
}

int main(void)
{
	int val;
	while ((val = lexer()) != 0)
		printf("Got %d\n", val);
	return 0;
}
