#!/bin/bash
# coca baseline test
source activate alfred_env
export DATA_ROOT=/fb-agios-acai-efs/dataset
export BASELINES=../EgoTV/baselines
cd $BASELINES/all_train

for run_id in 1 2 3
do
  echo "=================== CoCa test ==================="
  for split in 'novel_tasks' 'novel_steps' 'novel_scenes' 'abstraction'
  do
    echo "===================================================="
    echo $run_id " | " $split
    echo "===================================================="
    CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 python -m torch.distributed.launch --nproc_per_node=8 coca_test.py --num_workers 2 --split_type $split --batch_size 32 --sample_rate 3 --run_id $run_id
#    ps -ef | grep 'violin_test.py' | grep -v grep | awk '{print $2}' | xargs -r kill -9
  done
done