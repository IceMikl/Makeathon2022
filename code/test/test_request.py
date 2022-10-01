
import requests
import json


#url = 'http://localhost:5566/check_image'
url_check_image = 'https://melanome-detection-server.azurewebsites.net/check_image'
files = {'melanoma_image': open('JPG_Test.jpg', 'rb')}
response_check_image = requests.post(url=url_check_image, files=files)
print(json.loads(response_check_image.content))

url_test = 'https://melanome-detection-server.azurewebsites.net/test'
response_test = requests.get(url=url_test)
print(response_test.content)

