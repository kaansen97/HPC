all: mandel_seq mandel_omp

mandel_seq: mandel_seq.c pngwriter.c
	gcc -o $@ -I. -O3 $^ -I/opt/homebrew/Cellar/libpng/1.6.40/include/libpng16 -L/opt/homebrew/Cellar/libpng/1.6.40/lib -lpng16


mandel_omp: mandel_omp.c pngwriter.c
	gcc -o $@ -I. -O3 $^ -I/opt/homebrew/Cellar/libpng/1.6.40/include/libpng16 -L/opt/homebrew/Cellar/libpng/1.6.40/lib -lpng16


clean:
	rm -rf mandel_seq
	rm -rf mandel_omp


clean:
	rm -rf mandel_seq
	rm -rf mandel_omp

