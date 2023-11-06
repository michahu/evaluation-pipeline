#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --time=47:59:59
#SBATCH --mem=16GB
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --job-name=ppt
#SBATCH --mail-type=BEGIN
#SBATCH --mail-user=myh2014@nyu.edu

model_dir=$1

module purge

cd /scratch/myh2014/evaluation-pipeline


srun singularity exec --nv \
--overlay /scratch/myh2014/singularity/50G.ext3:ro \
/scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif  /bin/bash -c \
"source /ext3/env.sh; conda activate babylm; python babylm_eval.py $model_dir 'decoder only'" 
``