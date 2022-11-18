from flask import Flask, request, jsonify
import werkzeug
import os, json


app = Flask(__name__)

@app.route('/')
def hello_world():
   return "Hello World!"


@app.route('/upload', methods=["GET", "POST"])
def upload():
    global filename
    global path

    filename = ""
    path = ""

    if request.method == "POST":
        imagefile = request.files['image']
        print(imagefile.filename)
        filename = werkzeug.utils.secure_filename(imagefile.filename)
        # imagefile.save("./uploadedimages/" + filename)
        # path = os.path.abspath(filename)
        return jsonify({
            "message": "Image uploaded successfully.",
            "filename": filename,
            # "path": path
        })

    if request.method == "GET":
        # return filename
        return jsonify({
            "filename": filename
        })
        return "Hi"


if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True, port=5000)



#other version:
        #if request.method == "POST":
        # files = request.files.getlist('image')
        # if len(files) == 1:
        #     filename = werkzeug.utils.secure_filename(files[0].filename)
        #     # files[0].save("./uploadedimages/" + filename)
        #     # path = os.path.abspath(filename)
        #     print(path)
        #     return jsonify({
        #         "message": "Image uploaded successfully.",
        #         "filename": filename,
        #         # "path": path
        #     })
        # else:
        #     for file in files:
        #         thename = werkzeug.utils.secure_filename(file.filename)
        #         filenameList.append(thename)
        #         # file.save("./uploadedimages/" + thename)
        #         # thepath = os.path.abspath(thename)
        #         # pathList.append(thepath)
        #     jsonNameStr = json.dumps(filenameList)
        #     # jsonPathStr = json.dumps(pathList)
        #     return jsonify({
        #         "message": "Image uploaded successfully.",
        #         "filename": jsonNameStr,
        #         # "path": jsonPathStr
        #     })