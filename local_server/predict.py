
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
from torchvision import transforms
from torchvision.utils import make_grid, save_image

import torch.nn as nn
from torch.nn import functional as F
import torch
from model import SimpleClassifier
import pytorch_lightning as pl

from gradcam import GradCAM, GradCAMpp
from utils import visualize_cam

import imageio as iio
from torchvision.utils import save_image


PATH_TO_MODEL = 'melornotdata_resnet_50.ckpt'


def grad_cam(image_path, model):
    model.eval()
    img = iio.imread(image_path)
    img = img.astype(np.uint8)
    pil_img = Image.fromarray(img).convert('RGB')
    torch_img = transforms.Compose([transforms.Resize((1024, 1024)),transforms.ToTensor()])(pil_img)
    gradcam = GradCAM.from_config(model_type='resnet', arch=model, layer_name='backbone.layer4')
    normed_torch_img = transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])(torch_img)[None]
    mask, logit = gradcam(normed_torch_img, class_idx=None)
    heatmap, cam_result = visualize_cam(mask, torch_img)
    images=[]
    images.extend([torch_img, heatmap, cam_result])

    grid_image = make_grid(images, nrow=1)
    result=transforms.ToPILImage()(grid_image)
    result = result.save("grad.jpg")
    return cam_result


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

def load_image(image_path, aug, device):
    image = np.array(Image.open(image_path))
    augmented = aug(image=image)
    image = augmented['image']
    image = np.transpose(image, (2, 0, 1)).astype(np.float32)
    image = torch.tensor(image, dtype=torch.float).to(device).unsqueeze(0)
    return image


def load_model(model_path, device):
    model = SimpleClassifier(model_name='resnet50', num_classes=2)
    checkpoint = torch.load(model_path, map_location=device)
    model.load_state_dict(checkpoint['state_dict'], strict=False)
    model = model.to(device)
    return model


def predict_one(model, image):
    model.eval()
    with torch.no_grad():
        prediction = model(image)
        print(prediction)
        sm = torch.nn.Softmax(dim=-1)
        probability = 100*sm(prediction)[0][0]
        if probability>100: probability = 100
        if probability<1: probability *=10
        return int(probability)

def make_prediction(image_path):
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    aug = create_augmentations()
    model = load_model(PATH_TO_MODEL, device)
    image = load_image(image_path, aug, device)
    grad_image = grad_cam(image_path, model)
    return predict_one(model, image), grad_image


def main():

    # files = glob.glob('../../jpeg/train/*')
    # for file in files:
        # print("File name {} prediction {}%".format(file, make_prediction(file)))

    # print(make_prediction('../melanoma_3.jpg'))
    probability, image = make_prediction('../melanoma_best.jpg')
    print("Melanoma probability:{}%".format(probability))
    save_image(image, "aue.png")


if __name__ == '__main__':
    main()
