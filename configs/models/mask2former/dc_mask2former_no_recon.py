_base_ = ['dc_mask2former.py']

model = dict(
    reconstruction_head = None,
    reconstruction_loss = None,
)
