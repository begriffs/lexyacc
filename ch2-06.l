%option nounput noinput
%{
#include <assert.h>
#include <stdbool.h>
#include <stdio.h>

int input_from_argv(char *buf, size_t max);
#undef YY_INPUT
#define YY_INPUT(buf,result,max) (result = input_from_argv(buf, max))

char *g_prog_name;
bool  g_verbose;

enum
{
	ARG_BLANK,
	ARG_INCOMPLETE,
	ARG_COMPLETE
} g_fname_status = ARG_BLANK;

%}

%s FNAME

%%

[ ]+        ;
<FNAME>[ ]+ ;

-h   |
"-?" |
--help {
	printf("Usage: %s [-h|-?|--help] [-v|--verbose] "
	       "[(-f|--file) filename]\n", g_prog_name);
}

--verbose |
-v { puts("Enabling verbose"); g_verbose = true; }

-f |
--filename {
	BEGIN FNAME;
	g_fname_status = ARG_INCOMPLETE;
}

<FNAME>[^ ]+ {
	BEGIN 0;
	printf("Using file %s\n", yytext);
	g_fname_status = ARG_COMPLETE;
}


.	/* ignore */;

%%

char **g_argv;
size_t g_arg_offset;

int main(int argc, char **argv)
{
	(void)argc;
	g_prog_name = *argv;
	g_argv      = argv+1;
	yylex();
	switch (g_fname_status)
	{
	case ARG_BLANK:
		puts("No filaname given");
		break;
	case ARG_INCOMPLETE:
		puts("Incomplete filaname argument");
		return EXIT_FAILURE;
	default:
		break;
	}
	return 0;
}

#define MIN(a,b) ((a) < (b) ? (a) : (b))

/* Very interesting example from the book, because it's
 * more than just scanning a string. We're building the
 * input by hopping from string to string and emitting a
 * fake space after each. */
int input_from_argv(char *buf, size_t max)
{
	if (!*g_argv)
		return 0; /* stop scanning */

	size_t remaining = strlen(*g_argv) - g_arg_offset,
		   copy_len  = MIN(remaining, max-1);

	if (copy_len)
		memcpy(buf, *g_argv + g_arg_offset, copy_len);

	if ((*g_argv)[g_arg_offset + copy_len] == '\0')
	{
		buf[copy_len++] = ' ';
		g_argv++;
		g_arg_offset = 0;
	}
	return copy_len;
}
