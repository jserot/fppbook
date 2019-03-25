all: double-dabble

run: run-double-dabble

conv: conv.c
	gcc -o conv conv.c

run-conv:
	./conv 4 123

double-dabble: double-dabble.c
	gcc -o double-dabble double-dabble.c

run-double-dabble:
	./double-dabble 243

clean:
	\rm -f conv double-dabble

clobber: clean
	\rm -f *~
