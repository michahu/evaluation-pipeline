#!/bin/bash

# Nov 7
# run for seed 1

# for treatment in {"extra","isabel","nothing","optimized"}
# do
#     for seed in 1 2 3
#     do
#         sbatch babylm_eval.slurm models/exp2/$treatment/2
#     done
# done

# sbatch babylm_eval.slurm models/exp2/nothing/2

# Nov 9

# for seed in 1 2 3
#     do
#     for treatment in {"extra","isabel","nothing","optimized","base_cfg"}
#     do
#         sbatch babylm_eval.slurm models/bert/$treatment/$seed encoder
#     done
# done


# sbatch babylm_eval.slurm models/longer_ppt decoder

# Nov 17
# blimp eval can't be parallelized due to locking

# sbatch babylm_eval.slurm models/exp2_other/ decoder

# sbatch babylm_eval.slurm models/exp2_bert/ encoder

# sbatch babylm_eval.slurm models/exp3/ decoder

# sbatch babylm_eval.slurm models/exp1-3epochs/ decoder

# Dec 1

# sbatch babylm_eval.slurm models/exp1_lr5e-4/ decoder

# Jan 16

# sbatch babylm_eval.slurm models/exchange_rate decoder

# Mar 18
# ltgbert evals

# sbatch babylm_eval.slurm models/ltgbert ltgbert
# sbatch babylm_eval.slurm models/ltgbert_100M ltgbert
# sbatch babylm_eval.slurm models/ltgbert_10M_fsdp ltgbert

# Mar 27
# running on filtered tasks
sbatch babylm_eval.slurm models/ltgbert ltgbert
