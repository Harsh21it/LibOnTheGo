import 'package:flutter/material.dart';

class BorrowABook extends StatefulWidget {
  const BorrowABook({super.key});
  @override
  State<BorrowABook> createState() {
    return _BorrowABookState();
  }
}

class _BorrowABookState extends State<BorrowABook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation Page'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/check_box.gif',
              scale: 1.75,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Borrowed Successfully',
              style: TextStyle(color: Colors.black, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
