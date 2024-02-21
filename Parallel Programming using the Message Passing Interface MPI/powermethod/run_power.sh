#! usr/bin/bash

for ((c=1; c<=16; c++))
do 
    echo "Setting OMP_NUM_THREADS to $c"
    echo $(mpirun -np $c ./powermethod)| tee -a output_power.data
#    echo $(./dotProduct)
done