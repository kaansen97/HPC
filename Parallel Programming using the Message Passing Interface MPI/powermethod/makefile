CC=mpicc
CFLAGS=-O3 -ld_classic

all: powermethod

powermethod: powermethod.c
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm -f powermethod
