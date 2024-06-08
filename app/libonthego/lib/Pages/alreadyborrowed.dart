import 'package:flutter/material.dart';

class AlreadyBorrowed extends StatefulWidget {
  const AlreadyBorrowed({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AlreadyBorrowedState();
  }
}

class _AlreadyBorrowedState extends State<AlreadyBorrowed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Already Borrowed'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.popUntil(
                    context, (route) => route.settings.name == '/');
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/images/DTU.png'), opacity: 0.3)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Already Borrowed!',
              style: TextStyle(color: Colors.black, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
