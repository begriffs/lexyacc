%option nounput noinput

%{
unsigned long comments, code, whitespace;
%}

%s COMMENT

%%

^[ \t]*"/*"               { BEGIN COMMENT; }
^[ \t]*"/*".*"*/"[ \t]*\n { comments++; } /* self-contained */

<COMMENT>"*/"[ \t]*\n { BEGIN 0; comments++; }
<COMMENT>"*/"         { BEGIN 0; }
<COMMENT>\n           { comments++; } /* I don't understand why they */
<COMMENT>.\n          { comments++; } /* have these two similar patterns */

^[ \t]*\n { whitespace++; }

.+"/*".*"*/".*\n { code++; } /* code before comment */
.*"/*".*"*/".+\n { code++; } /* code after comment */
.+"/*".*\n       { code++; BEGIN COMMENT; }
.\n              { code++; }

.                ; /* ignore */

%%

int main(void)
{
	yylex();
	printf("Code %lu, comments: %lu, whitespace: %lu\n",
			comments, code, whitespace);
	return 0;
}
