#! usr/bin/bash

for ((c=1; c<=10; c++))
do 
    echo "Setting OMP_NUM_THREADS to $c" | tee -a output_stencil.data
    export OMP_NUM_THREADS=$c
    echo $(mpirun -np 1 ./main 512 512 100 0.01)| tee -a output_stencil.data
    echo $(mpirun -np 2 ./main 512 512 100 0.01)| tee -a output_stencil.data
    echo $(mpirun -np 4 ./main 512 512 100 0.01)| tee -a output_stencil.data
done
