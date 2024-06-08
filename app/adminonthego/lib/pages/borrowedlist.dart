import 'package:adminonthego/pages/booklist.dart';
import 'package:adminonthego/pages/navbar.dart';
import 'package:flutter/material.dart';

class BorrowedBooks extends StatefulWidget {
  const BorrowedBooks({super.key, required this.userId});
  final String userId;
  @override
  State<BorrowedBooks> createState() => _BorrowedBooksState();
}

class _BorrowedBooksState extends State<BorrowedBooks> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrowed Books'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/images/DTU.png'), opacity: 0.3)),
        child: BookList(userId: widget.userId),
      ),
      bottomNavigationBar: const NavigatorBar(),
    );
  }
}
