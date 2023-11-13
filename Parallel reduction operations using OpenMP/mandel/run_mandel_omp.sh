#!/bin/bash -l

#SBATCH --job-name=mandel
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --output=mandel-%j.txt


echo "========= mandelbrot_omp ======================"
./mandel_omp | tee -a output_50t_omp.data
echo
