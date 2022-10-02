
from flask import Flask, request, jsonify, send_file
from predict import make_prediction

app = Flask(__name__)

@app.route('/test', methods=['GET'])
def hello():
    return "Hello, World!", 200


@app.route('/check_image', methods=['POST'])
def check_image():
    melanoma_image_path="melanoma_image_tmp.jpg"
    melanoma_image = request.files.get('melanoma_image', '')
    melanoma_image.save(melanoma_image_path)
    results = __check_melanoma_image(melanoma_image_path=melanoma_image_path)

    data = {
        'melanoma_detected': 'false',
        "processing_time": 0,
        "results": str(results)
    }
    # return send_file(melanoma_image_result_path, mimetype='image/jpeg')
    return jsonify(data), 200


def __check_melanoma_image(melanoma_image_path):
    results = make_prediction(melanoma_image_path)
    return results

if __name__ == '__main__':
    app.run(port=5566)
