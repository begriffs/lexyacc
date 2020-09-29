.POSIX:

CFLAGS = -std=c99 -g -pedantic -Wall -Wextra -D_POSIX_C_SOURCE=200112L
LDLIBS = -ll

.SUFFIXES :
.SUFFIXES : .o .c .l

all : ch1-01 ch1-02 ch1-04

clean :
	find . -maxdepth 1 -perm -111 -type f -exec rm {} +
