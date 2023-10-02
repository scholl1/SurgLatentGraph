#!/bin/bash
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --gres=gpu:1
#SBATCH --time=15:00:00
#SBATCH -p gpu_p2
#SBATCH -J test_small_wc_faster
#SBATCH --error test_small_wc_faster_error.log
#SBATCH --output test_small_wc_faster.log
#SBATCH -A lbw@v100

module purge
module load anaconda-py3/2019.03
module load gcc/9.3.0
module load cuda/10.2
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/lib64
export MMDETECTION=${WORK}/mmdet_files
export PYTHONPATH=${PYTHONPATH}:/gpfsscratch/rech/lbw/uou65jw/sid/latentgraph


cd $SCRATCH/sid/latentgraph
source $(conda info --base)/bin/activate
conda activate camma

cd ./configs/models/ && \
        ./select_dataset.sh small_wc && \
        cd ../.. && \
        python ${MMDETECTION}/tools/test.py configs/models/faster_rcnn/lg_faster_rcnn.py small_wc/lg_faster_rcnn/best_small_wc_bbox_mAP_epoch_17.pth  --work-dir lg_faster_rcnn/small_wc && \


cd ./configs/models/ && \
        ./select_dataset.sh endoscapes && \
        cd ../.. && \
	python ${MMDETECTION}/tools/test.py configs/models/faster_rcnn/lg_faster_rcnn.py small_wc/lg_faster_rcnn/best_small_wc_bbox_mAP_epoch_17.pth --work-dir lg_faster_rcnn/endoscapes &
wait
