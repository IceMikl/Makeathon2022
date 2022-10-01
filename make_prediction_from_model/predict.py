import torch
import glob
import numpy as np
import argparse
import pandas as pd
import albumentations
from tqdm import tqdm
import sklearn
import os
from sklearn import metrics
from datetime import date, datetime
import pytz
import logging
import torchvision
from torchvision.transforms import FiveCrop, ToTensor, Lambda, Normalize, TenCrop
from PIL import Image
import pretrainedmodels
import torch.nn as nn
from torch.nn import functional as F
import torch
from efficientnet_pytorch import EfficientNet


#Change this to the correct model path
PATH_TO_MODEL = 'efficientnet-b3_fold_0_200_0.9026687240037569.bin'



#Efficient Net model class
class EfficientNetBx(nn.Module):
    def __init__(self, pretrained=True, arch_name='efficientnet-b3', ce=False):
        super(EfficientNetBx, self).__init__()
        self.pretrained = pretrained
        self.ce = ce
        self.base_model = EfficientNet.from_pretrained(arch_name) if pretrained else EfficientNet.from_name(arch_name)
        nftrs = self.base_model._fc.in_features
        self.base_model._fc = nn.Linear(nftrs, 1) if not ce else nn.Linear(nftrs, 8)  #predict diagnosis instead

    def forward(self, image):
        out = self.base_model(image)
        return out



def create_augmentations():
    mean = (0.485, 0.456, 0.406)
    std  = (0.229, 0.224, 0.225)
    sz = 200
    num_crops = 10
    tta = False
    test_aug = albumentations.Compose([
            albumentations.CenterCrop(sz, sz),
            albumentations.Normalize(mean, std, max_pixel_value=255.0, always_apply=True),
        ]) if not tta else torchvision.transforms.Compose([
            TenCrop(sz) if num_crops==10 else FiveCrop(sz),
            Lambda(lambda crops: torch.stack([ToTensor()(crop) for crop in crops])),
            Lambda(lambda crops: torch.stack([Normalize(mean=mean, std=std)(crop) for crop in crops]))
        ])
    return test_aug


def load_model(model_path, device):
    MODEL_DISPATCHER = {
    'efficient_net': EfficientNetBx
    }
    model = MODEL_DISPATCHER['efficient_net'](pretrained=False)
    model.load_state_dict(torch.load(model_path))
    model = model.to(device)
    return model


def load_image(image_path, aug):
    image = np.array(Image.open(image_path))
    augmented = aug(image=image)
    image = augmented['image']
    image = np.transpose(image, (2, 0, 1)).astype(np.float32)
    image = torch.tensor(image, dtype=torch.float).to('cuda').unsqueeze(0)
    return image

def predict_one(model, image):
    model.eval()
    with torch.no_grad():

        prediction = model(image)
        return torch.sigmoid(prediction)



def make_prediction(image_path):
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

    #define augmentation
    aug = create_augmentations()
    model = load_model(PATH_TO_MODEL, device)
    image = load_image(image_path, aug)

    return predict_one(model, image)


def main():
    print(make_prediction('melanoma.jpg').item())
    print(make_prediction('not_melanoma.jpg').item())

if __name__ == '__main__':
    main()
