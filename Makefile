CFLAGS = -std=c99 -g -pedantic -Wall -Wextra -D_POSIX_C_SOURCE=200112L
LDLIBS = -ll -ly

.SUFFIXES :
.SUFFIXES : .o .c .l .y

all : ch1-01 ch1-02 ch1-04 ch1-05

ch1-04 : ch1-04.o symbol_table.o

ch1-%.tab.c ch1-%.tab.h : ch1-%.y
	$(YACC) -d -b ${<:.y=} $<

ch1-%.lex.c : ch1-%.l ch1-%.tab.h
	$(LEX) -t $< > $@

ch1-% : ch1-%.tab.o ch1-%.lex.o symbol_table.o
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

clean :
	find . -maxdepth 1 -perm -111 -type f -exec rm {} +
	rm *.tab.h
