
from flask import Flask, request, jsonify, send_file
from predict import make_prediction
from torchvision.utils import save_image

import io
from base64 import encodebytes
from PIL import Image

app = Flask(__name__)

@app.route('/test', methods=['GET'])
def hello():
    return "Hello, World!", 200


@app.route('/check_image', methods=['POST'])
def check_image():
    melanoma_image_path="melanoma_image_tmp.jpg"
    melanoma_image = request.files.get('melanoma_image', '')
    melanoma_image.save(melanoma_image_path)
    probability, image = __check_melanoma_image(melanoma_image_path=melanoma_image_path)

    path_to_analyzed_image = "analyzed_melanoma_image.jpg"
    save_image(image, path_to_analyzed_image)
    data = {
        'melanoma_detected': 'false',
        "processing_time": 0,
        "probability": str(probability),
        "image_bytes": get_response_image(path_to_analyzed_image)
    }
    # return send_file(melanoma_image_result_path, mimetype='image/jpeg')
    return jsonify(data), 200


def get_response_image(image_path):
    pil_img = Image.open(image_path, mode='r') # reads the PIL image
    byte_arr = io.BytesIO()
    pil_img.save(byte_arr, format='PNG') # convert the PIL image to byte array
    encoded_img = encodebytes(byte_arr.getvalue()).decode('ascii') # encode as base64
    return encoded_img


def __check_melanoma_image(melanoma_image_path):
    probability, image = make_prediction(melanoma_image_path)
    return probability, image

if __name__ == '__main__':
    app.run(port=5566)
