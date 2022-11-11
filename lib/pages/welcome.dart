import 'package:flutter/material.dart';
import 'package:my_test_app/pages/upload.dart';
import 'package:my_test_app/constants.dart' as constants;

class Welcome extends StatelessWidget {

  const Welcome({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(constants.title_home),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text(
            "Start",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UploadImage()),
            );
          },
        ),
      ),
    );
  }
}