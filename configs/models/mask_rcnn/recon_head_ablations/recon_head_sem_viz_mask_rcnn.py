_base_ = '../lg_ds_mask_rcnn.py'

model = dict(
    reconstruction_head=dict(
        # turn off img feats in reconstruction head
        use_img=False,
    ),
)
