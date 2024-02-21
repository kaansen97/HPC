#! usr/bin/bash

for size in 128 256 512 1024
do
    for ((c=1; c<=8; c++))
    do 
        echo "Setting Processes to $c for size $size" | tee -a strong_scaling.data
        echo $(mpirun -np $c ./main $size $size 100 0.01)| tee -a strong_scaling.data
    done
done

