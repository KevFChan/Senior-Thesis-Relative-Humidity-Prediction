#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH -t 5:00:00
#SBATCH -J Hourly_Feglm_1-2AM
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=64G

echo '-------------------------------'
cd ${SLURM_SUBMIT_DIR}
echo ${SLURM_SUBMIT_DIR}
echo Running on host $(hostname)
echo Time is $(date)
echo SLURM_NODES are $(echo ${SLURM_NODELIST})
echo '-------------------------------'
echo -e '\n\n'
module load R/4.2.0-foss-2020b
Rscript FeglmModel1_2AM.R
