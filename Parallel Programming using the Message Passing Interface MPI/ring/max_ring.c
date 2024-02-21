/****************************************************************
 *                                                              *
 * This file has been written as a sample solution to an        *
 * exercise in a course given at the CSCS-USI Summer School.    *
 * It is made freely available with the understanding that      *
 * every copy of this file must include this header and that    *
 * CSCS/USI take no responsibility for the use of the enclosed  *
 * teaching material.                                           *
 *                                                              *
 * Purpose: Parallel maximum using a ping-pong                      *
 *                                                              *
 * Contents: C-Source                                           *
 *                                                              *
 ****************************************************************/


#include <stdio.h>
#include <mpi.h>


int main (int argc, char *argv[])
{
    int my_rank, size;
    int snd_buf, rcv_buf;
    int right, left;
    int max, i;
    int tag = 0;

    MPI_Status  status;
    MPI_Request request;


    MPI_Init(&argc, &argv);

    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);

    MPI_Comm_size(MPI_COMM_WORLD, &size);


    right = (my_rank+1)%size;/* get rank of neighbor to your right */
    left  = ((my_rank-1)+size)%size;/* get rank of neighbor to your left */

    /* Implement ring maximum code
     * do not use if (rank == 0) .. else ..
     * every rank sends initialy its rank number to a neighbor, and then sends what
     * it receives from that neighbor, this is done n times with n = number of processes
     * all ranks will obtain the max.
     */
    snd_buf=my_rank;
    max = (3 * my_rank) % (2 * size);
    rcv_buf=0;
    for (i = 0; i < size; i++) {

        MPI_Sendrecv(&snd_buf, 1, MPI_INT, right, tag,&rcv_buf, 1, MPI_INT, left, tag,MPI_COMM_WORLD, &status);
        if(max<rcv_buf){
            max=rcv_buf;
        }
        snd_buf = max;
    }

    printf ("Process %i:\tMax = %i\n", my_rank, max);

    MPI_Finalize();
    return 0;
}
