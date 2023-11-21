import os

_base_ = ['lg_base_box.py']

# metric
val_evaluator = dict(
    type='CocoMetricRGD',
    prefix='cholecT50',
    data_root=_base_.data_root,
    data_prefix=_base_.val_data_prefix,
    ann_file=os.path.join(_base_.data_root, 'val/annotation_ds_coco.json'),
    metric=['bbox', 'segm'],
    additional_metrics=['reconstruction'],
    use_pred_boxes_recon=False,
    num_classes=-1, # ds_num_classes
)

test_evaluator = dict(
    type='CocoMetricRGD',
    prefix='cholecT50',
    data_root=_base_.data_root,
    data_prefix=_base_.test_data_prefix,
    ann_file=os.path.join(_base_.data_root, 'test/annotation_ds_coco.json'),
    metric=['bbox', 'segm'],
    additional_metrics=['reconstruction'],
    use_pred_boxes_recon=False,
    num_classes=-1, # ds num classes
    outfile_prefix='./results/cholecT50_preds/test',
)

default_hooks = dict(
    checkpoint=dict(save_best='cholecT50/segm_mAP'),
)