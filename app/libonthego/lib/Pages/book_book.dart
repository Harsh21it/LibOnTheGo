import 'package:flutter/material.dart';
import 'package:libonthego/Pages/book_a_book.dart';

class BookBook extends StatefulWidget {
  const BookBook({super.key});
  @override
  State<StatefulWidget> createState() {
    return _BookBookState();
  }
}

class _BookBookState extends State<BookBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a book'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/images/DTU.png'), opacity: 0.3)),
        child: const Expanded(
          child: Column(
            children: [
              SizedBox(height: 750, child: BookABook()),
            ],
          ),
        ),
      ),
    );
  }
}
