_base_ = '../lg_ds_mask_rcnn.py'

model = dict(
    # remove visual features in ds head
    ds_head=dict(
        final_viz_feat_size=0,
    ),
)
