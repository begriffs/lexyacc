Questions from my experiments

* How can I avoid adding the boilerplate `%option nounput noinput`
  to every lex file? Tried `LFLAGS = -DYY_NO_UNPUT -DYY_NO_INPUT`
  in the Makefile, but flex no longer supports those macros.
  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=192109
* How to enable debug symbols in final program? Perhaps they
  aren't found because the lex make rule removes object files
  after successful build.
* ch1-04.l - can you somehow use X-macros in rules?
* ch1-05.y - why must I define yyerror and yylex as extern myself?
	ch1-05.tab.c:1039:16: warning: implicit declaration of function 'yylex' is invalid in
		  C99 [-Wimplicit-function-declaration]
		  yychar = yylex ();
				   ^
	ch1-05.tab.c:1180:7: warning: implicit declaration of function 'yyerror' is invalid
		  in C99 [-Wimplicit-function-declaration]
		  yyerror (YY_("syntax error"));
		  ^
	ch1-05.tab.c:1291:3: warning: implicit declaration of function 'yyerror' is invalid
		  in C99 [-Wimplicit-function-declaration]
	  yyerror (YY_("memory exhausted"));
	  ^
* ch1-05.y - why does yyin default to NULL? I had to set it to stdout
