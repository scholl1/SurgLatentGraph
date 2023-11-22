import os

# dataset, optimizer, and runtime cfgs
_base_ = [
    '../datasets/cholecT50/cholecT50_instance.py',
    os.path.expandvars('$MMDETECTION/configs/_base_/schedules/schedule_1x.py'),
    os.path.expandvars('$MMDETECTION/configs/_base_/default_runtime.py')
]

data_root = _base_.data_root
val_data_prefix = _base_.val_dataloader.dataset.data_prefix.img
test_data_prefix = _base_.test_dataloader.dataset.data_prefix.img

orig_imports = _base_.custom_imports.imports
custom_imports = dict(imports=orig_imports + ['model.simple_cvs_predictor', 'evaluator.CocoMetricRGD'], allow_failed_imports=False)

model = dict(
    type='SimpleCVSPredictor',
    backbone=dict(
        type='ResNet',
        depth=50,
        num_stages=4,
        out_indices=(0, 1, 2, 3),
        frozen_stages=-1,
        norm_cfg=dict(type='BN', requires_grad=True),
        norm_eval=True,
        style='pytorch',
        init_cfg=dict(type='Pretrained',
            checkpoint='torchvision://resnet50')),
    loss=dict(
        type='CrossEntropyLoss',
        use_sigmoid=True,
    ),
    loss_consensus='mode',
    num_classes=100,
    data_preprocessor=dict(
        type='DetDataPreprocessor',
        mean=[123.675, 116.28, 103.53],
        std=[58.395, 57.12, 57.375],
        bgr_to_rgb=True,
        pad_mask=True,
        pad_size_divisor=1,
    ),
)

# dataset
train_dataloader = dict(
    batch_size=32,
    num_workers=2,
    dataset=dict(
        ann_file='train/annotation_ds_coco.json',
    ),
)
val_dataloader = dict(
    batch_size=32,
    num_workers=2,
    dataset=dict(
        ann_file='val/annotation_ds_coco.json',
    ),
)
test_dataloader = dict(
    batch_size=32,
    num_workers=2,
    dataset=dict(
        ann_file='test/annotation_ds_coco.json',
    ),
)

# evaluators
train_evaluator = dict(
    type='CocoMetricRGD',
    prefix='cholecT50',
    data_root=_base_.data_root,
    data_prefix=_base_.train_eval_dataloader.dataset.data_prefix.img,
    ann_file=os.path.join(_base_.data_root, 'train/annotation_ds_coco.json'),
    use_pred_boxes_recon=True,
    metric=[],
    agg='video',
    num_classes=100,
    ds_per_class=False,
    outfile_prefix='./results/cholecT50_preds/train/r50',
)
val_evaluator = dict(
    type='CocoMetricRGD',
    prefix='cholecT50',
    data_root=_base_.data_root,
    data_prefix=_base_.val_dataloader.dataset.data_prefix.img,
    ann_file=os.path.join(_base_.data_root, 'val/annotation_ds_coco.json'),
    use_pred_boxes_recon=True,
    metric=[],
    agg='video',
    num_classes=100,
    ds_per_class=False,
    outfile_prefix='./results/cholecT50_preds/val/r50',
)

test_evaluator = dict(
    type='CocoMetricRGD',
    prefix='cholecT50',
    data_root=_base_.data_root,
    data_prefix=_base_.test_dataloader.dataset.data_prefix.img,
    ann_file=os.path.join(_base_.data_root, 'test/annotation_ds_coco.json'),
    metric=[],
    agg='video',
    num_classes=100,
    ds_per_class=False,
    #additional_metrics = ['reconstruction'],
    use_pred_boxes_recon=True,
    outfile_prefix='./results/cholecT50_preds/test/r50',
)

# optimizer
del _base_.param_scheduler
optim_wrapper = dict(
    _delete_=True,
    optimizer=dict(type='AdamW', lr=0.00001),
)
auto_scale_lr = dict(enable=False)

# Running settings
train_cfg = dict(
    type='EpochBasedTrainLoop',
    max_epochs=20,
    val_interval=1)
val_cfg = dict(type='ValLoop')
test_cfg = dict(type='TestLoop')

# hooks
metric_key = 'ds_video_average_precision' if test_evaluator['agg'] == 'video' else 'ds_average_precision'
default_hooks = dict(
    checkpoint=dict(save_best='cholecT50/{}'.format(metric_key)),
)
