#!/bin/bash
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --gres=gpu:1
#SBATCH --time=15:00:00
#SBATCH -p gpu_p2
#SBATCH -J test_endoscapes_small_wc_mask
#SBATCH --error test_endoscapes_small_wc_mask_error.log
#SBATCH --output test_endoscapes_small_wc_mask.log
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
        python ${MMDETECTION}/tools/test.py configs/models/mask_rcnn/lg_mask_rcnn.py weights/endoscapes/lg_mask_rcnn_no_recon.pth  --work-dir lg_mask_rcnn/endoscapes_small_wc &



wait