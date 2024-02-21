#!/bin/bash
#BSUB -W 00:10
#BSUB -n 4
#BSUB -J pde-miniapp-py


    echo "Setting Processes to 1 for size 128" | tee -a Weak_scaling.data
    echo "Running with size: 128, Process: 1"
    time mpiexec -n 1 python main.py 128 100 0.01 verbose | tee -a Weak_scaling.data

    echo "Setting Processes to 2 for size 256" | tee -a Weak_scaling.data
    echo "Running with size: 256, Process: 2"
    time mpiexec -n 2 python main.py 256 100 0.01 verbose | tee -a Weak_scaling.data

    echo "Setting Processes to 4 for size 512" | tee -a Weak_scaling.data
    echo "Running with size: 512, Process: 4"
    time mpiexec -n 4 python main.py 512 100 0.01 verbose | tee -a Weak_scaling.data

    echo "Setting Processes to 8 for size 1024" | tee -a Weak_scaling.data
    echo "Running with size: 1024, Process: 8"
    time mpiexec -n 2 python main.py 256 100 0.01 verbose | tee -a Weak_scaling.data
    