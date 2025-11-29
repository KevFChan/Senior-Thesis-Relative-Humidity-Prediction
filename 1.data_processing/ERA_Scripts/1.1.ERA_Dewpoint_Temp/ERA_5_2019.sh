#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH -t 12:00:00
#SBATCH -J ERA5_2019_Cleaning
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=32G

echo '-------------------------------'
cd ${SLURM_SUBMIT_DIR}
echo ${SLURM_SUBMIT_DIR}
echo Running on host $(hostname)
echo Time is $(date)
echo SLURM_NODES are $(echo ${SLURM_NODELIST})
echo '-------------------------------'
echo -e '\n\n'
module load R/4.2.0-foss-2020b
Rscript ERA_2019_Parallel.R
