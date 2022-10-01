
import requests
import json


#url = 'http://localhost:5566/'

url = 'https://melanome-detection-server.azurewebsites.net/'

url_test = url + 'test'
response_test = requests.get(url=url_test)
print(response_test.content)


url_check_image = url + 'check_image'
files = {'melanoma_image': open('JPG_Test.jpg', 'rb')}
response_check_image = requests.post(url=url_check_image, files=files)
print(response_check_image.content)


