_base_ = '../lg_ds_mask_rcnn.py'

model = dict(
    reconstruction_head=dict(
        # turn off graph viz and graph sem feats in reconstruction head
        use_visual=False,
        use_semantics=False,
    ),
)
