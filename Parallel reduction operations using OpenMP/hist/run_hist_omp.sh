#! usr/bin/bash

for ((c=1; c<=24; c++))
do 
    export OMP_NUM_THREADS=$c
    echo "Setting OMP_NUM_THREADS to $c"
    echo $(./hist_omp)| tee -a output_24t_omp.data

done