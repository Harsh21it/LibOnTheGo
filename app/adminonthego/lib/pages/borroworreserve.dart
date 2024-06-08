import 'package:adminonthego/pages/borrowedlist.dart';
import 'package:adminonthego/pages/navbar.dart';
import 'package:adminonthego/pages/reservedlist.dart';
import 'package:flutter/material.dart';

class BorrowOrReserve extends StatefulWidget {
  const BorrowOrReserve({super.key, required this.userId});
  final String userId;

  @override
  State<StatefulWidget> createState() {
    return _BorrowOrReserveState();
  }
}

class _BorrowOrReserveState extends State<BorrowOrReserve> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrow or Reserve'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(image: AssetImage('assets/images/DTU.png'))),
        child: Center(
          child: Card(
            color: const Color.fromARGB(162, 255, 255, 255),
            child: Container(
              height: 250,
              margin: const EdgeInsets.all(16),
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 5),
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage('assets/images/borrowedbooks.jpg'),
                    opacity: 0.7,
                    fit: BoxFit.cover),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BorrowedBooks(userId: widget.userId)));
                    },
                    icon: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 5),
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage('assets/images/book1.jpg'),
                            fit: BoxFit.cover),
                      ),
                      child: const Center(
                          child: Text(
                        'Borrowed Books',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ReservedBooks(userId: widget.userId)));
                    },
                    icon: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 5),
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage('assets/images/book1.jpg'),
                            fit: BoxFit.cover),
                      ),
                      child: const Center(
                        child: Text(
                          'Reserved Books',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavigatorBar(),
    );
  }
}
