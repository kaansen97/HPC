#!/bin/bash -l

#SBATCH --job-name=mandel
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --output=mandel-%j.txt


echo "========= mandelbrotseq ======================"
./mandel_seq | tee -a output_50t_seq.data
echo
