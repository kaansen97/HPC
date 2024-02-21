#! usr/bin/bash

for ((c=1; c<=24; c++))
do 
    export OMP_NUM_THREADS=$c
    echo "Setting OMP_NUM_THREADS to $c"
    echo $(./main 1024 100 0.005 )| tee -a output_1024_24t.data
done