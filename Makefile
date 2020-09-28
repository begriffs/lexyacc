.POSIX:

CFLAGS = -std=c99 -g -pedantic -Wall -Wextra
LDLIBS = -ll

all : ch1-01 ch1-02

clean :
	find . -maxdepth 1 -perm -111 -type f -exec rm {} +

.c:
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LDLIBS)
