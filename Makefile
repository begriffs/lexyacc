.POSIX:

CFLAGS = -std=c99 -g -pedantic -Wall -Wextra -D_POSIX_C_SOURCE=200112L
LDLIBS = -ll

.SUFFIXES :
.SUFFIXES : .o .c .l .y

all : ch1-01 ch1-02 ch1-04 ch1-05

ch1-04 : ch1-04.o symbol_table.o

ch1-05 : ch1-05.l ch1-05.y symbol_table.o
	$(LEX) -t ch1-05.l > ch1-05.lex.c
	$(YACC) -d -b ch1-05 ch1-05.y
	$(CC) $(CFLAGS) -c ch1-05.lex.c
	$(CC) $(CFLAGS) ch1-05.tab.c symbol_table.o ch1-05.lex.o -o ch1-05 -ll -ly
	rm ch1-05{.lex,.tab}.[ch]

clean :
	find . -maxdepth 1 -perm -111 -type f -exec rm {} +
