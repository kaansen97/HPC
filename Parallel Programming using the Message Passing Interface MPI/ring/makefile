CC=mpicc
CFLAGS=-O3 -ld_classic

all: max_ring

max_ring: max_ring.c
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm -f max_ring

