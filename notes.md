Questions from my experiments

## Chapter 1

* How can I avoid adding the boilerplate `%option nounput noinput`
  to every lex file? Tried `LFLAGS = -DYY_NO_UNPUT -DYY_NO_INPUT`
  in the Makefile, but flex no longer supports those macros.
  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=192109
* How to enable debug symbols in final program? Perhaps they
  aren't found because the lex make rule removes object files
  after successful build.
* ch1-04.l - can you somehow use X-macros in rules?
* ch1-05.y - why must I define yyerror and yylex as extern myself?
  My own code doesn't use them directly, so I would hope that the generated
  C parser would #include whatever was needed...
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

## Chapter 2

* How to deal with international characters?
	- Character classes and ranges
		- lex-U algorithm https://www.w3.org/2005/03/23-lex-U
		- implement it, and have it output a comment before the rule
		  showing it written with unicode
	- How to detect word breaks? Can you use a C function rather than
	  a regex to lex certain tokens? It could tie into ICU that way
	- Can I maintain my own version of yyleng that measures in
	  graphemes rather than UTF-8 code units?
	- Maybe I would operate directly on yytext and not consult yyleng
	  in the unicode case.
* Why does ch2-03 declare some global variables in the definition
  section, and others in the C code section?
	A: appears to be that definitio section vars are referenced in
	   rules, whereas the others are used by internal code
* How to build an object file that exports
	struct *thing f(char *s)
  which lexes/parses s? How to make that thread-safe? Probably consult
  a thread-local variable in input(). Can the same translation unit
  export g() that parses in a different way? Test this in a threaded
  program.
  - Actually flex has a mode to build a reentrant scanner
* If two object files both came from lex and were used in the same
  executable, would tye yylex() etc functions conflict?
* It's getting annoying that I lose my vim indentation helpers within
  the C blocks in .l files. Using :set ft="lex.c" mixes them nicely.
  Weirdly, "c.lex" messes up and shows syntax error colors.
  Research in here
  https://vim.fandom.com/wiki/Different_syntax_highlighting_within_regions_of_a_file
* Slightly different signatures, unput() returns int in modern posix
* POSIX lex has no way to read input except through a FILE\* interface.
  "The input() routine is not redefinable." http://westes.github.io/flex/manual/Lex-and-Posix.html#Lex-and-Posix
  To read from a string, or from a custom function like ch2-06.l, requires
  AT&T lex or flex. Flex is so common nowadays that might as well use it,
  and try to deviate from POSIX as little as possible in other respects.

## Chapter 3

* Is it best to declare a shared global in the .l file as extern, and
  define it in the .y file?
* It's easier to mimic the tfind/tsearch interface with my symbol table,
  rather than st_lookup (aka find) and st_add (add full structure, return
  true or false if new entry was created).
