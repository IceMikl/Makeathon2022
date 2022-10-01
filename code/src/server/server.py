
from flask import Flask, request, Response, jsonify

app = Flask(__name__)

@app.route('/check_image', methods=['POST'])
def hello():
    melanoma_image = request.files.get('melanoma_image', '')
    print(melanoma_image)
    __check_melanoma_image(melanoma_image=melanoma_image)

    data = {
        'melanoma_detected': 'false',
        "processing_time": 0
    }
    return jsonify(data), 200


def __check_melanoma_image(melanoma_image):
    pass


if __name__ == '__main__':
    app.run(port=5566)
