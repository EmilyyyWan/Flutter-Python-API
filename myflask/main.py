from flask import Flask, request, jsonify
import werkzeug
import os


app = Flask(__name__)

# @app.route('/')
# def hello_world():
#    return "Hello in main.py"

filename = ""
path = ""

@app.route('/upload', methods=["GET", "POST"])
def upload():
    global filename
    global path

    if request.method == "POST":
        imagefile = request.files['image']
        print(imagefile.filename)
        filename = werkzeug.utils.secure_filename(imagefile.filename)
        imagefile.save("./uploadedimages/" + filename)
        path = os.path.abspath(filename)
        print(path)
        return jsonify({
            "message": "Image uploaded successfully.",
            "filename": filename,
            "path": path
        })
    if request.method == "GET":
        return jsonify({
            "path": path
        })
        return "Hi"

if __name__ == "__main__":
    app.run(debug=True,port=5000)
