import 'package:flutter/material.dart';
import 'package:my_test_app/pages/upload.dart';
import 'package:my_test_app/constants.dart' as constants;

class Success extends StatelessWidget {

  const Success({super.key});


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
              "Image uploaded successfully!",
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
}