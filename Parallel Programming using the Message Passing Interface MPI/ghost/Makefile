CC=mpicc
CFLAGS=-O3 -ld_classic

all: ghost

ghost: ghost.c
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm -f ghost

