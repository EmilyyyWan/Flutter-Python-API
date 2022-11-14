import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_test_app/pages/upload.dart';
import 'package:my_test_app/constants.dart' as constants;
import 'package:http/http.dart' as http;


class Success extends StatelessWidget {
  final String message;
  const Success({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(constants.title_success),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              // "Image uploaded successfully!",
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              child: const Text(
                'Start over',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UploadImage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // State<StatefulWidget> createState() => _SuccessState();

}



// class _SuccessState extends State<Success> {
//   String path = "";
//
//   Future<void> fetchResult() async {
//     String url = "";
//     if (Platform.isAndroid) {
//       url = "http://10.0.2.2:5000/upload";
//     } else {
//       url = "http://127.0.0.1:5000/upload";
//     }
//
//     var response = await http.get(Uri.parse(url));
//     var resJson = jsonDecode(response.body);
//     var thepath = resJson['path'];
//
//     setState(() {
//       path = thepath;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(constants.title_success),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               widget.message,
//               // "Image uploaded successfully!",
//               style: TextStyle(fontSize: 20),
//             ),
//             ElevatedButton(
//               child: const Text(
//                 'Start over',
//                 style: TextStyle(fontSize: 20),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const UploadImage()),
//                 );
//               },
//             ),
//             ElevatedButton(
//               child: const Text(
//                 'Show path',
//                 style: TextStyle(fontSize: 20),
//               ),
//               onPressed: () {
//                 fetchResult();
//               },
//             ),
//             Text(
//               path,
//               style: TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }