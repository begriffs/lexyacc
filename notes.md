Questions from my experiments

* How can I avoid adding the boilerplate `%option nounput noinput`
  to every lex file? Tried `LFLAGS = -DYY_NO_UNPUT -DYY_NO_INPUT`
  in the Makefile, but flex no longer supports those macros.
  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=192109
* How to enable debug symbols in final program? Perhaps they
  aren't found because the lex make rule removes object files
  after successful build.
* ch1-04.l - can you somehow use X-macros in rules?
