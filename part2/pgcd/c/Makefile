CC	= gcc
CCOPTS	= #-DDEBUG

all: tb

tb: tb.c pgcd.c
	$(CC) $(CCOPTS) -o tb pgcd.c tb.c

run: tb
	./tb

clean:
	-rm -f *~ *.o tb
