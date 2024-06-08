import 'package:adminonthego/pages/books.dart';
import 'package:adminonthego/pages/studentdetails.dart';
import 'package:flutter/material.dart';

class NavigatorBar extends StatelessWidget {
  const NavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Students()));
            },
            icon: Image.asset(
              'assets/images/student.png',
              width: 80,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Books()));
            },
            icon: Image.asset(
              'assets/images/Book.png',
              width: 90,
            ),
          ),
        ],
      ),
    );
  }
}
