#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH -t 12:00:00
#SBATCH -J ERA5_Merging_Grid_Ids
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=80G

echo '-------------------------------'
cd ${SLURM_SUBMIT_DIR}
echo ${SLURM_SUBMIT_DIR}
echo Running on host $(hostname)
echo Time is $(date)
echo SLURM_NODES are $(echo ${SLURM_NODELIST})
echo '-------------------------------'
echo -e '\n\n'
module load R/4.2.0-foss-2020b
Rscript MergingRHGrid_Ids.R
