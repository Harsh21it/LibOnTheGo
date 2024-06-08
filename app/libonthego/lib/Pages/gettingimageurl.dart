import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class GettingBookURl extends StatelessWidget {
  const GettingBookURl({super.key});
  void submit() async {
    final storageRef =
        FirebaseStorage.instance.ref().child('books_images').child('AI.jpg');
    final imageURL = await storageRef.getDownloadURL();
    // ignore: avoid_print
    print(imageURL);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextButton(onPressed: submit, child: const Text('get details!')),
    );
  }
}
