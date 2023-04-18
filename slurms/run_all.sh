detector=$1
base_cfg_dir=configs/models
cfg_dir=$base_cfg_dir/$detector
dataset='endoscapes'

# run lg pretraining
#python $MMDETECTION/tools/train.py $cfg_dir/lg_$detector.py
best_model_path=work_dirs/lg_$detector/best_$dataset/$(ls work_dirs/lg_$detector/best_$dataset/)

#python $MMDETECTION/tools/test.py $cfg_dir/lg_$detector.py $best_model_path

# copy checkpoint to weights
#cp $best_model_path weights/lg_$detector_no_recon.pth

# extract backbone weights from lg detector weights
# python weights/extract_bb_weights.py weights/lg_$detector_no_recon.pth weights/lg_$detector_bb.pth

# run lg ds (with/without recon)
#python $MMDETECTION/tools/train.py $cfg_dir/lg_ds_$detector.py
#python $MMDETECTION/tools/test.py $cfg_dir/lg_ds_$detector.py work_dirs/lg_$detector/best_$dataset/$(ls work_dirs/lg_$detector/best_$dataset)
#python $MMDETECTION/tools/train.py $cfg_dir/lg_ds_$detector_no_recon.py
#python $MMDETECTION/tools/test.py $cfg_dir/lg_ds_$detector_no_recon.py.py work_dirs/lg_$detector/best_$dataset/$(ls work_dirs/lg_$detector/best_$dataset)

# run deepcvs
#python $MMDETECTION/tools/train.py $cfg_dir/dc_ds_$detector.py
#python $MMDETECTION/tools/test.py $cfg_dir/dc_ds_$detector.py work_dirs/dc_$detector/best_$dataset/$(ls work_dirs/dc_$detector/best_$dataset)
#python $MMDETECTION/tools/train.py $cfg_dir/dc_ds_$detector_no_recon.py
#python $MMDETECTION/tools/test.py $cfg_dir/dc_ds_$detector_no_recon.py.py work_dirs/dc_$detector/best_$dataset/$(ls work_dirs/dc_$detector/best_$dataset)

# run mt
#python $MMDETECTION/tools/train.py $base_cfg_dir/simple_cvs_predictor.py --work-dir ./work_dirs/mt_$detector --cfg_options load_from=weights/lg_$detector_bb.pth
#python $MMDETECTION/tools/train.py $base_cfg_dir/simple_cvs_predictor_with_recon.py --work-dir ./work_dirs/mt_$detector_with_recon --cfg_options load_from=weights/lg_$detector_bb.pth
#python $MMDETECTION/tools/test.py $base_cfg_dir/simple_cvs_predictor.py work_dirs/mt_$detector/$(ls work_dirs/mt_$detector/best_$dataset) --work-dir ./work_dirs/mt_$detector
#python $MMDETECTION/tools/test.py $base_cfg_dir/simple_cvs_predictor_with_recon.py work_dirs/mt_$detector_with_recon/$(ls work_dirs/mt_$detector_with_recon/best_$dataset) --work-dir ./work_dirs/mt_$detector_with_recon
