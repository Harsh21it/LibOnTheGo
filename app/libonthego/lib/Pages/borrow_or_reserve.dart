import 'package:flutter/material.dart';
import 'package:libonthego/Pages/book_book.dart';
import 'package:libonthego/widget/barcode.dart';

class BorrowOrReserve extends StatefulWidget {
  const BorrowOrReserve({super.key});

  @override
  State<BorrowOrReserve> createState() {
    return _BorrowOrReserve();
  }
}

class _BorrowOrReserve extends State<BorrowOrReserve> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/images/DTU.jpg'), opacity: 0.4)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBar(
            title: const Text('Borrow or Reserve'),
          ),
          const SizedBox(
            height: 250,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/images/book1.jpg'),
                          fit: BoxFit.cover,
                          opacity: 0.6),
                      border: const Border.symmetric(
                          horizontal: BorderSide(color: Colors.black, width: 2),
                          vertical: BorderSide(color: Colors.black, width: 2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_box_outlined,
                            color: Colors.black,
                            size: 50,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BarcodeScan()));
                              },
                              child: const Text(
                                'Borrow\n Now',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.grey[50],
                borderOnForeground: true,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/images/reserve.jpg'),
                          fit: BoxFit.cover,
                          opacity: 0.6),
                      border: const Border.symmetric(
                          horizontal: BorderSide(color: Colors.black, width: 2),
                          vertical: BorderSide(color: Colors.black, width: 2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 29, horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.lock_clock_outlined,
                            color: Colors.black,
                            size: 50,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BookBook()));
                              },
                              child: const Text(
                                'Reserve for\n     Later',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
