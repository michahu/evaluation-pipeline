#!/bin/bash

LR=${1:-5e-5}
PATIENCE=${2:-10}
BSZ=${3:-64}
EVAL_EVERY=${4:-200}
MAX_EPOCHS=${5:-3}
SEED=${6:-12}

# Fine-tune and evaluate on (Super)GLUE tasks
# If your system uses sbatch or qsub, consider using that to parallelize calls to finetune_model.sh
# for subtask in {"cola","sst2","mrpc","qqp","mnli","mnli-mm","qnli","rte","boolq","multirc","wsc"}; do

# Nov 7
# for treatment in {"extra","nothing"}
# do
#     for subtask in {"cola","sst2","mrpc","qqp","mnli","mnli-mm","qnli","qqp","rte","wnli"}; do
#         sbatch finetune_model.slurm models/exp1/$treatment/1 glue $subtask $LR $PATIENCE $BSZ $EVAL_EVERY $MAX_EPOCHS $SEED
#     done
# done

# GPT-2 sanity check
# for subtask in {"cola","sst2","mrpc","qqp","mnli","mnli-mm","qnli","qqp","rte","wnli"}; do
#     sbatch finetune_model.slurm models/gpt2 glue $subtask $LR $PATIENCE $BSZ $EVAL_EVERY $MAX_EPOCHS $SEED
# done

# ./finetune_model.sh $MODEL_PATH glue cola $LR $PATIENCE $BSZ $EVAL_EVERY $MAX_EPOCHS $SEED


# Fine-tune and evaluate on MSGS tasks
# for subtask in {"main_verb_control","control_raising_control","syntactic_category_control","lexical_content_the_control","relative_position_control","main_verb_lexical_content_the","main_verb_relative_token_position","syntactic_category_lexical_content_the","syntactic_category_relative_position","control_raising_lexical_content_the","control_raising_relative_token_position"}; do
# 	./finetune_model.sh $MODEL_PATH msgs $subtask $LR $PATIENCE $BSZ $EVAL_EVERY $MAX_EPOCHS $SEED
# done

# Nov 17
# for treatment in {"extra","isabel","nothing","optimized","base_cfg"}
# do
#     for seed in 1 2 3
#     do
#         for subtask in {"cola","sst2","mrpc","qqp","mnli","mnli-mm","qnli","qqp","rte","wnli"}; do
#             sbatch finetune_model.slurm models/exp2/$treatment/$seed glue $subtask $LR $PATIENCE $BSZ $EVAL_EVERY $MAX_EPOCHS $SEED
#         done
#     done
# done

# for treatment in {"extra","isabel","nothing","optimized","extra_1k","extra_og"}
# treatment="base_cfg"
treatment="personal_estimate"
# do
for seed in 1 2 4
do
    for subtask in {"cola","sst2","mrpc","qqp","mnli","mnli-mm","qnli","qqp","rte","wnli","stsb"}; do
        sbatch finetune_model.slurm models/exp1_v3/$treatment/$seed glue $subtask $LR $PATIENCE $BSZ $EVAL_EVERY $MAX_EPOCHS $SEED
    done
done
# done

# treatment="isabel"
# seed=1
# for subtask in {"cola","sst2","mrpc","qqp","mnli","mnli-mm","qnli","qqp","rte","wnli"}; do
#     sbatch finetune_model.slurm models/exp2_bert/$treatment/$seed glue $subtask $LR $PATIENCE $BSZ $EVAL_EVERY $MAX_EPOCHS $SEED
# done

# Nov 18
# for treatment in {"optimized_og","optimized_10k_og","optimized_10k"}
# do
#     for seed in 1 2 3
#     do
#         for subtask in {"cola","sst2","mrpc","qqp","mnli","mnli-mm","qnli","qqp","rte","wnli","stsb"}
#         do 
#             sbatch finetune_model.slurm models/exp2_other/$treatment/$seed glue $subtask $LR $PATIENCE $BSZ $EVAL_EVERY $MAX_EPOCHS $SEED "gpt2"
#         done
#     done
# done

# subtask="stsb"

# for treatment in {"extra","isabel","nothing","optimized","base_cfg"}
# do
#     for seed in 1 2 3
#     do
#         sbatch finetune_model.slurm models/exp2/$treatment/$seed glue $subtask $LR $PATIENCE $BSZ $EVAL_EVERY $MAX_EPOCHS $SEED "gpt2"
#     done
# done

# for treatment in {"extra","isabel","nothing","optimized","base_cfg"}
# do
#     for seed in 1 2 3
#     do
#         sbatch finetune_model.slurm models/exp2_bert/$treatment/$seed glue $subtask $LR $PATIENCE $BSZ $EVAL_EVERY $MAX_EPOCHS $SEED "bert-base-uncased"
#     done
# done