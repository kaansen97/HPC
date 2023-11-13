/* 
    Please include compiler name below (you may also include any other modules you would like to be loaded)

COMPILER= gnu

    Please include All compiler flags and libraries as you want them run. You can simply copy this over from the Makefile's first few lines
 
CC = cc
OPT = -O3
CFLAGS = -Wall -std=gnu99 $(OPT)
MKLROOT = /opt/intel/composer_xe_2013.1.117/mkl
LDLIBS = -lrt -Wl,--start-group $(MKLROOT)/lib/intel64/libmkl_intel_lp64.a $(MKLROOT)/lib/intel64/libmkl_sequential.a $(MKLROOT)/lib/intel64/libmkl_core.a -Wl,--end-group -lpthread -lm

*/

const char* dgemm_desc = "Naive, three-loop dgemm.";

#define minimum(x,y)({__typeof__ (x) _x = (x); __typeof__ (y) _y = (y); _x < _y ? _x : _y ;})



/* This routine performs a dgemm operation
 *  C := C + A * B
 * where A, B, and C are lda-by-lda matrices stored in column-major format.
 * On exit, A and B maintain their input values. */    
void square_dgemm (int n, double* A, double* B, double* C)
{
  // TODO: Implement the blocking optimization
 const int block_size=24;
  
  /* For each row i of A */
  for (int i_ = 0; i_ < n; i_ += block_size) {
    for (int j_ = 0; j_ < n; j_ += block_size) {
      for (int k_ = 0; k_ < n; k_ += block_size) {
        for (int i = i_; i < minimum(n,(i_+block_size)); i++) { 
          for (int j = j_; j < minimum(n,(j_+block_size)); j++) {
            double cij = C[(i)+(j)*n];
            for (int k = k_; k < minimum(n,(k_+block_size)); k++) {
              cij += A[(i)+(k)*n] * B[(k)+(j)*n];
            }
            C[(i)+(j)*n] = cij;
          }
        }
      }
    }
  }
}

