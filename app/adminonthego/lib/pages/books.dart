import 'package:adminonthego/pages/booksdetails.dart';
import 'package:adminonthego/pages/navbar.dart';
import 'package:flutter/material.dart';

class Books extends StatefulWidget {
  const Books({super.key});
  @override
  State<StatefulWidget> createState() {
    return _BooksState();
  }
}

class _BooksState extends State<Books> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      bottomNavigationBar: const NavigatorBar(),
      body: const BookABook(),
    );
  }
}
