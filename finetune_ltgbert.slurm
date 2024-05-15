#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --output=glue-%j.out
#SBATCH --time=47:59:59
#SBATCH --mem=16GB
#SBATCH --gres=gpu:1
#SBATCH --job-name=ppt
#SBATCH --mail-type=BEGIN
#SBATCH --mail-user=myh2014@nyu.edu

MODEL_PATH=$1
TASK_NAME=$2
SUBTASK_NAME=$3
LR=${4:-5e-5}           # default: 5e-5
PATIENCE=${5:-10}       # default: 10
BSZ=${6:-64}            # default: 64
EVAL_EVERY=${7:-200}    # default: 200
MAX_EPOCHS=${8:-10}      # default: 10
SEED=${9:-12}           # default: 12

if [[ "$SUBTASK_NAME" = "mnli" ]]; then
    VALID_NAME="validation_matched"
    OUT_DIR="mnli-$MAX_EPOCHS"
elif [[ "$SUBTASK_NAME" = "mnli-mm" ]]; then
    VALID_NAME="validation_mismatched"
    SUBTASK_NAME="mnli"
    OUT_DIR="mnli-mm-$MAX_EPOCHS"
else
    VALID_NAME="validation"
    OUT_DIR="$SUBTASK_NAME-$MAX_EPOCHS"
fi

mkdir -p $MODEL_PATH/finetune/$OUT_DIR/

echo "MODEL_PATH: $MODEL_PATH"

srun singularity exec --nv \
--overlay /scratch/myh2014/singularity/50G.ext3:ro \
/scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif  /bin/bash -c \
"source /ext3/env.sh; conda activate babylm; python finetune_classification.py \
  --model_name_or_path $MODEL_PATH \
  --output_dir $MODEL_PATH/finetune/$OUT_DIR/ \
  --train_file filter-data/${TASK_NAME}_filtered/$SUBTASK_NAME.train.json \
  --validation_file filter-data/${TASK_NAME}_filtered/$SUBTASK_NAME.$VALID_NAME.json \
  --do_train \
  --do_eval \
  --do_predict \
  --use_fast_tokenizer False \
  --max_seq_length 128 \
  --per_device_train_batch_size $BSZ \
  --learning_rate $LR \
  --num_train_epochs $MAX_EPOCHS \
  --evaluation_strategy steps \
  --patience $PATIENCE \
  --eval_every $EVAL_EVERY \
  --eval_steps $EVAL_EVERY \
  --save_steps $EVAL_EVERY \
  --overwrite_output_dir \
  --seed $SEED"


#   --train_file filter-data/${TASK_NAME}_filtered/$SUBTASK_NAME.train.json \
#   --validation_file filter-data/${TASK_NAME}_filtered/$SUBTASK_NAME.$VALID_NAME.json \