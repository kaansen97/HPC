

for size in 128 256 512 1024
do
    for threads in {1..8}
    do
        echo "Setting processes to $threads for size $size" | tee -a Strong_scaling.data

        echo "Running with size: $size and Processes $threads" 
        time mpiexec -n $threads python main.py $size 100 0.01 verbose | tee -a Strong_scaling.data
    done
done
exit
