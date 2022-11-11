from flask import Flask, request, jsonify
import werkzeug
import os


app = Flask(__name__)

# @app.route('/')
# def hello_world():
#    return "Hello in main.py"


@app.route('/upload', methods=["GET", "POST"])
# @cross_origin()
def upload():
    if request.method == "POST":
        # imagefile = request.files.get('image')
        imagefile = request.files['image']
        print(imagefile.filename)
        filename = werkzeug.utils.secure_filename(imagefile.filename)
        imagefile.save("./uploadedimages/" + filename)
        currdir = os.path.abspath(filename)
        print(currdir)
        return jsonify({
            "message": "Image uploaded successfully."
        })
    if request.method == "GET":
        return "Hi"

if __name__ == "__main__":
    app.run(debug=True,port=5000)
