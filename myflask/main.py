from flask import Flask, request, jsonify
import werkzeug
import os, json


app = Flask(__name__)

# @app.route('/')
# def hello_world():
#    return "Hello in main.py"


@app.route('/upload', methods=["GET", "POST"])
def upload():
    global filename
    global path
    global filenameList
    global pathList
    global jsonNameStr
    global jsonPathStr

    filename = ""
    path = ""
    filenameList = []
    pathList = []
    jsonNameStr = ""
    jsonPathStr = ""

    if request.method == "POST":
        files = request.files.getlist('image')
        if len(files) == 1:
            filename = werkzeug.utils.secure_filename(files[0].filename)
            files[0].save("./uploadedimages/" + filename)
            path = os.path.abspath(filename)
            print(path)
            return jsonify({
                "message": "Image uploaded successfully.",
                "filename": filename,
                "path": path
            })
        else:
            for file in files:
                thename = werkzeug.utils.secure_filename(file.filename)
                filenameList.append(thename)
                file.save("./uploadedimages/" + thename)
                thepath = os.path.abspath(thename)
                # print(thepath)
                pathList.append(thepath)
            jsonNameStr = json.dumps(filenameList)
            jsonPathStr = json.dumps(pathList)
            return jsonify({
                "message": "Image uploaded successfully.",
                "filename": jsonNameStr,
                "path": jsonPathStr
            })

    if request.method == "GET":
        return jsonNameStr
        return jsonify({
            "path": path
        })
        return "Hi"


if __name__ == "__main__":
    app.run(debug=True,port=5000)


#last version:
        # imagefile = request.files['image']
        # print(imagefile.filename)
        # filename = werkzeug.utils.secure_filename(imagefile.filename)
        # imagefile.save("./uploadedimages/" + filename)
        # path = os.path.abspath(filename)
        # print(path)
        # return jsonify({
        #     "message": "Image uploaded successfully.",
        #     "filename": filename,
        #     "path": path
        # })