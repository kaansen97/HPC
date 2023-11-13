all: dotProduct

dotProduct: dotProduct.cpp walltime.h
	g++-13 -O3 -fopenmp $< -o $@ -ld_classic

clean:
	rm -rf dotProduct
