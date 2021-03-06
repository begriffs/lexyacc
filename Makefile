.POSIX:

CFLAGS = -std=c99 -g -pedantic -Wall -Wextra -D_POSIX_C_SOURCE=200112L
LDLIBS = -ll

.SUFFIXES :
.SUFFIXES : .o .c .l .y

all : ch1-01 ch1-02 ch1-04 ch1-05 ch1-lex-vs-c-1 ch1-lex-vs-c-2 \
	  ch2-03 ch2-06 ch2-09 \
	  ch3-02 ch3-04 \
	  ch4

ch1-04 : ch1-04.o symbol_table.o

symbol_table.o : symbol_table.c symbol_table.h

include config.mk

clean :
	find . -name 'ch*' -maxdepth 1 -perm -111 -type f -exec rm {} +
	rm -f *.lex.* *.tab.* *.o
