
import requests
import json


url = 'http://localhost:5566/check_image'
files = {'melanoma_image': open('JPG_Test.jpg', 'rb')}
response = requests.post(url=url, files=files)
print(json.loads(response.content))