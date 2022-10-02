import base64
import json
import os
import requests
import shutil


api = 'http://localhost:5000/postimage'
path_img = 'melanoma.jpg'

with open(path_img, 'rb') as img:
  name_img= os.path.basename(path_img)
  files= {'image': (name_img,img,'multipart/form-data',{'Expires': '0'}) }
  with requests.Session() as s:
    r = s.post(api,files=files)
    print(r.content)
    with open("received.jpg", 'wb') as f:
        f.write(r.content)
