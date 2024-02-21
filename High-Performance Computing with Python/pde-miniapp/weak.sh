#! usr/bin/bash

for size in 128 256 512 1024
do
    case $size in
        128)
            threads=1
            ;;
        256)
            threads=2
            ;;
        512)
            threads=4
            ;;
        1024)
            threads=8
            ;;
        *)
            echo "Unsupported size: $size"
            continue
            ;;
    esac

    echo "Setting processes to $threads for size $size" | tee -a output_weak_scaling.data
    echo $(mpirun -np $threads ./main $size $size 100 0.01)| tee -a output_weak_scaling.data
done
