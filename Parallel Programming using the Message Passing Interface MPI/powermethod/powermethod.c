/****************************************************************
 *                                                              *
 * This file has been written as a sample solution to an        *
 * exercise in a course given at the CSCS-USI Summer School.    *
 * It is made freely available with the understanding that      *
 * every copy of this file must include this header and that    *
 * CSCS/USI take no responsibility for the use of the enclosed  *
 * teaching material.                                           *
 *                                                              *
 * Purpose: : Parallel matrix-vector multiplication and the     *
 *            and power method                                  *
 *                                                              *
 * Contents: C-Source                                           *
 *                                                              *
 ****************************************************************/


#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include <math.h>
#include "hpc-power.h"
#include "hpc-power.c"
 
int rank, size;

double normalizeVec(double *vector, int n) {

   double result = 0;
   for(int i = 0; i < n; i++)
       result += vector[i]*vector[i];
 
   return sqrt(result);
}
 
void createMatrix(double *matrix, int n) {
   
   MPI_Comm_rank(MPI_COMM_WORLD, &rank);
   MPI_Comm_size(MPI_COMM_WORLD, &size);
  
   for(int i = 0; i < n; i++) {
       for(int j = 0; j < n/size; j++) {
               matrix[i+n*j] = 1;
        }
    }
}
 
void matVec(double *matrix, double *vector,double *result, int n) {
   
   MPI_Comm_rank(MPI_COMM_WORLD, &rank);
   MPI_Comm_size(MPI_COMM_WORLD, &size);
  
   MPI_Bcast(vector, n, MPI_DOUBLE, 0, MPI_COMM_WORLD);
   double *y;
   y = (double *)malloc(sizeof(double)*(n/size));

   for( int i = 0; i < n/size; i++){
       for(int j = 0; j < n; j++){ 
            y[i] += matrix[j+n*i] * vector[j];
        }
    }
   MPI_Gather(y, n/size, MPI_DOUBLE, result, n/size, MPI_DOUBLE, 0, MPI_COMM_WORLD);
}
 
double powerMethod(double *matrix, int n) {
   int rank;
   MPI_Comm_rank(MPI_COMM_WORLD, &rank);
   double *vector;
   vector = (double *)malloc(sizeof(double)*(n));
   if( rank == 0){
       for( int i = 0; i < n; i++){
           if ( i % 2 == 0)
           {
              vector[i] = 1;
           }
           else
           vector[i] = 0;
       }
   }
  
   for( int j = 0; j < 1000; j++) {
       if( rank == 0) {
           double norm = normalizeVec(vector,n);
           for(int k = 0; k < n; k++){ vector[k] = vector[k]/norm; }
       }

       double *y;
       y = (double *)malloc(sizeof(double)*(n));
       matVec(matrix,vector,y,n);
       if( rank == 0) {
           for( int i = 0; i < n; i++ ) { 
            vector[i] = y[i]; 
            }      
       }
   }
   return normalizeVec(vector,n);
}
 
int main (int argc, char *argv[])
{
   int my_rank, size;
   int snd_buf, rcv_buf;
   int right, left;
   int sum, i;
   int n = 8000;
 
   MPI_Status  status;
   MPI_Request request;
   MPI_Init(&argc, &argv);
   MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
   MPI_Comm_size(MPI_COMM_WORLD, &size);
 
   /* This subproject is about to write a parallel program to
      multiply a matrix A by a vector x, and to use this routine in
      an implementation of the power method to find the absolute
      value of the largest eigenvalue of the matrix. Your code will
      call routines that we supply to generate matrices, record
      timings, and validate the answer.
   */
   double *matrix;
   matrix = (double *)malloc(sizeof(double)*(n*n/size));
   createMatrix(matrix,n);
  
   double start = MPI_Wtime();
   double lambda = powerMethod(matrix,n);
   double stop = MPI_Wtime();
 
   double sum_times = 0;
   double tot_time = 0;
   double timediff = stop - start;
   double *times;
   times = (double *)malloc(sizeof(double)*(size));
  
   MPI_Gather(&timediff, 1, MPI_DOUBLE, times, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);
   if(my_rank == 0){
        for(int i=0; i<size; i++) {
           sum_times += times[i];
       }
       tot_time = sum_times/size;
   }
  
   if(my_rank == 0)
       printf("dimension\t%d \tlambda \t%f \t time \t%f\n",n,lambda,tot_time);
   MPI_Finalize();
   return 0;
}
 
 

