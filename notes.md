Questions from my experiments

* How can I avoid adding the boilerplate `%option nounput noinput`
  to every lex file? Tried `LFLAGS = -DYY_NO_UNPUT -DYY_NO_INPUT`
  in the Makefile, but flex no longer supports those macros.
  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=192109
