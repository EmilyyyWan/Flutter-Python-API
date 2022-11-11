import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_test_app/constants.dart' as constants;
import 'package:image_picker/image_picker.dart';
import 'package:my_test_app/pages/success.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<StatefulWidget> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {

  XFile? image;
  File? imgFile;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    // var img = await picker.pickImage(source: media);
    //
    // setState(() {
    //   image = img;
    // });

    var img = await picker.pickImage(source: media);
    imgFile = File(img!.path);
    setState(() {
      image = img;
    });
  }



  Future<void> selectSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: Text('Camera'),
              onPressed: () {
                Navigator.pop(context);
                getImage(ImageSource.camera);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Gallery'),
              onPressed: () {
                Navigator.pop(context);
                getImage(ImageSource.gallery);
              },
            )
          ],
        ),
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 6,
            ),
            child: ListView(children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
              ),
            ]),
          );
        }
      );
    }

  } //end selectSource()



  Future<void> uploadImage() async {
    // String url = "http://10.0.2.2:5000/upload";
    // String url = "http://127.0.0.1:5000/upload";

    String url = "";
    if (Platform.isAndroid) {
      url = "http://10.0.2.2:5000/upload";
    } else {
      url = "http://127.0.0.1:5000/upload";
    }

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(http.MultipartFile(
      'image',
      imgFile!.readAsBytes().asStream(),
      imgFile!.lengthSync(),
      // filename: 'sample.jpg'
      filename: image!.path.split("/").last
    ));
    // var headers = {"Content_Type": "multipart/form_data"};
    // request.headers.addAll(headers);
    var response = await request.send();


    // http.Response res  = await http.Response.fromStream(response);
    // var resJson = jsonDecode(res.body);
    // String message = resJson['message'];


    if(response.statusCode == 200){
      print("success");
    }
    if(response.statusCode == 404){
      print("Not Found");
    }
    if(response.statusCode == 400){
      print("Bad Request");
    }

    setState(() {});

  } //end uploadImage()




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(constants.title_upload),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('upload'),
              onPressed: () {
                selectSource(context);
              },
            ),

            SizedBox(
              height: 10,
            ),

            if (image != null) Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                        File(image!.path),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                    ),
                  ),
              )
            else
              Text(
                "No Image",
                style: TextStyle(fontSize: 20),
              ),

            if (image != null) ElevatedButton(
              child: const Text('submit'),
              onPressed: () {
                uploadImage();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Success()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }


}
