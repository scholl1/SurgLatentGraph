_base_ = '../lg_ds_mask_rcnn.py'

model = dict(
    reconstruction_head=dict(
        # turn off graph viz feats in reconstruction head
        use_visual=False,
    ),
)
