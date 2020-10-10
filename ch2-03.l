%option nounput noinput

%{
#include <stdio.h>

unsigned long n_char, n_word, n_line;
%}

word [^ \t\n]+
eol \n

%%

{word}	{ n_word++; n_char += yyleng; }
{eol}	{ n_char++; n_line++; }
.		{ n_char++; }

%%

char **paths;
size_t cur_path, n_paths;
unsigned long total_char, total_word, total_line;

int main(int argc, char **argv)
{
	paths    = argv+1;
	n_paths  = argc-1;

	yywrap();
	yylex();

	puts("---------------------------------------");
	printf("%8lu %8lu %8lu TOTAL\n",
		total_char, total_word, total_line);
	
	return 0;
}

extern FILE *yyin;

int yywrap(void)
{
	if (0 < cur_path)
	{
		printf("%8lu %8lu %8lu %s\n",
			n_char, n_word, n_line, paths[cur_path-1]);
		total_char += n_char;
		total_word += n_word;
		total_line += n_line;
		n_char = n_word = n_line = 0;
		fclose(yyin);
	}
	FILE *f;
	for (f = NULL; paths[cur_path] && !f; cur_path++)
	{
		if (!(f = fopen(paths[cur_path], "r")))
			fprintf(stderr, "Cannot open %s\n", paths[cur_path]);
		else
			yyin = f;
	}
	return f ? 0 : 1;
}
