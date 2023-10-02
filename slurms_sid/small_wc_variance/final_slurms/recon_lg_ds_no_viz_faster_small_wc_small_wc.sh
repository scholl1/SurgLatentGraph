#!/bin/bash 
#SBATCH -N 3 
#SBATCH --cpus-per-task 10 
#SBATCH --gres=gpu:3 
#SBATCH --time=10:00:00 
#SBATCH -p gpu_p2 
#SBATCH -J recon_lg_ds_no_viz_faster_small_wc_small_wc 
#SBATCH --error recon_lg_ds_no_viz_faster_small_wc_small_wc_error.log 
#SBATCH --output recon_lg_ds_no_viz_faster_small_wc_small_wc.log  
#SBATCH -A lbw@v100 


module purge 
module load anaconda-py3/2019.03 
module load gcc/9.3.0 
module load cuda/10.2 
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/lib64 
export MMDETECTION=${WORK}/mmdet_files 
export PYTHONPATH=${PYTHONPATH}:/gpfsscratch/rech/lbw/uou65jw/sid/latentgraph/ 


cd $SCRATCH/sid/latentgraph 
source $(conda info --base)/bin/activate 
conda activate camma 

./slurms_sid/small_wc_variance/run_test_recon.sh lg_ds_no_viz faster_rcnn small_wc small_wc 
