import json
from flask import Flask, request, jsonify
from flask import send_file

app = Flask(__name__)

import os
from predict import *

@app.route('/')
def hello_world():
    return "Hello world"

@app.route("/postimage", methods=["POST"])
def process_image():
    print(request.files)
    file = request.files['image']
    print(file)
    file.save("uploaded.jpg")

    probability, image = make_prediction('uploaded.jpg')
    print("Melanoma probability:{}%".format(probability))
    save_image(image, "aue.png")

    return send_file("aue.png", mimetype='image/png')






app.run()
