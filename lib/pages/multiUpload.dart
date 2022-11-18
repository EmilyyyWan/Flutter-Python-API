import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_test_app/constants.dart' as constants;
import 'package:image_picker/image_picker.dart';
import 'package:my_test_app/pages/success.dart';


class MultiImageUpload extends StatefulWidget {
  const MultiImageUpload({super.key});

  @override
  State<StatefulWidget> createState() => _MultiImageUploadState();
}


class _MultiImageUploadState extends State<MultiImageUpload> {

  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageList = [];
  String result = "";

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageList!.addAll(selectedImages);
    }
    setState(() {
    });
  }


  Future<void> uploadImage() async {
    String url = "https://flask-service.onislsvnbg6j8.ca-central-1.cs.amazonlightsail.com/upload";
    // if (Platform.isAndroid) {
    //   url = "http://10.0.2.2:5000/upload";
    // } else {
    //   url = "http://127.0.0.1:5000/upload";
    // }

    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));

    List<http.MultipartFile> imageFileList = [];
    File file;
    for(XFile img in imageList!){
      file = File(img.path);
      imageFileList.add(http.MultipartFile(
        'image',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: file.path.split("/").last
      ));
    }
    request.files.addAll(imageFileList);

    var response = await request.send();

    http.Response res  = await http.Response.fromStream(response);
    var resJson = jsonDecode(res.body);
    String message = resJson['message'];
    String filename = resJson['filename'];
    String path = resJson['path'];

    if(response.statusCode == 200){
      print("success");
    }
    if(response.statusCode == 404){
      print("Not Found");
    }
    if(response.statusCode == 400){
      print("Bad Request");
    }

    setState(() {
      result = filename;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Success(message: result)),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(constants.title_upload),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                child: const Text(
                  'Pick Images from Gallery',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  selectImages();
                },
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        itemCount: imageList!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Image.file(File(imageList![index].path), fit: BoxFit.cover);
                        }
                    ),
                  )
              ),
              if (imageList!.isNotEmpty) Container(
                margin: EdgeInsets.only(bottom: 25),
                child: ElevatedButton(
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    uploadImage();
                  },
                ),
              )
            ],
          ),
        )
    );
  }


}
