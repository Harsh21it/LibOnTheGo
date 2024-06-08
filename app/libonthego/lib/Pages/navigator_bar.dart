import 'package:flutter/material.dart';
import 'package:libonthego/Pages/borrowed_books.dart';
import 'package:libonthego/Pages/finepay.dart';
import 'package:libonthego/Pages/menu.dart';
import 'package:libonthego/Pages/reservedBooks.dart';
import 'package:libonthego/Pages/user_page.dart';

class NavigatorBar extends StatelessWidget {
  const NavigatorBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: (Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FinePay()));
            },
            icon: Image.asset(
              'assets/images/Fine.png',
              width: 50,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BorrowedBooks()));
            },
            icon: Image.asset(
              'assets/images/borrowed.png',
              width: 70,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReservedBooks()));
              },
              icon: Image.asset(
                'assets/images/reserved.png',
                width: 60,
              )),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const UserPage()));
            },
            icon: Image.asset(
              'assets/images/user.png',
              width: 60,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MenuPage()));
            },
            icon: Image.asset(
              'assets/images/Menu.png',
              width: 60,
            ),
          ),
        ],
      )),
    );
  }
}
