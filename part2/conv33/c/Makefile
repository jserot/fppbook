CC	= gcc
CCOPTS	= #-DDEBUG

all: tb

tb: img.c conv33.c tb.c
	$(CC) $(CCOPTS) -o tb img.c conv33.c tb.c

run: tb
	./tb lena128.pgm res.pgm

clean:
	-rm -f *~ *.o tb
