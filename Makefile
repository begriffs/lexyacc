.POSIX:

CFLAGS = -std=c99 -g -pedantic -Wall -Wextra -D_POSIX_C_SOURCE=200112L
LDLIBS = -ll

.SUFFIXES :
.SUFFIXES : .o .c .l .y

all : ch1-01 ch1-02 ch1-04 ch1-05

ch1-04 : ch1-04.o symbol_table.o

ch1-05.tab.c ch1-05.tab.h : ch1-05.y
	$(YACC) -d -b ch1-05 ch1-05.y

ch1-05.lex.c : ch1-05.l ch1-05.tab.h
	$(LEX) -t ch1-05.l > ch1-05.lex.c

ch1-05 : ch1-05.tab.o ch1-05.lex.o symbol_table.o
	$(CC) $(LDFLAGS) -o $@ ch1-05.tab.o symbol_table.o ch1-05.lex.o -ll -ly

clean :
	find . -maxdepth 1 -perm -111 -type f -exec rm {} +
