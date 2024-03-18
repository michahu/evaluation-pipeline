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
model_type=$2

module purge

cd /scratch/myh2014/evaluation-pipeline

# for ((treatment = 1000; treatment <= 5000; treatment += 1000)); 
# do
#     seed=0
#     echo "Running evaluation for treatment: $treatment"

#     for ((i = 250; i <= treatment; i += 250)); 
#     do
#         srun singularity exec --nv \
#         --overlay /scratch/myh2014/singularity/50G.ext3:ro \
#         /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif  /bin/bash -c \
#         "source /ext3/env.sh; conda activate babylm; python babylm_eval.py $model_dir/$treatment/$seed-ppt/$i/ $model_type" 
#     done
# done

# for ((treatment = 1000; treatment <= 5000; treatment += 1000)); 
# do
# treatment=5000
# seed=0
# echo "Running evaluation for treatment: $treatment"

# for ((i = 250; i <= 5000; i += 250)); 
# do
#     srun singularity exec --nv \
#     --overlay /scratch/myh2014/singularity/50G.ext3:ro \
#     /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif  /bin/bash -c \
#     "source /ext3/env.sh; conda activate babylm; python babylm_eval.py $model_dir/isabel-$treatment/$seed/$i/ $model_type" 
# done
# done


# Iterate over each subdirectory
for subdirectory in "$model_dir"/*/; do
    echo "Running evaluation for subdirectory: $subdirectory"

    # Execute the command for each subdirectory
    srun singularity exec --nv \
        --overlay /scratch/myh2014/singularity/50G.ext3:ro \
        /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif  /bin/bash -c \
        "source /ext3/env.sh; conda activate babylm; python babylm_eval.py $subdirectory $model_type"
done