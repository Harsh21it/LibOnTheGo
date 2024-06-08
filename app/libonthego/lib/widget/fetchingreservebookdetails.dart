import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libonthego/Pages/alreadyborrowed.dart';
import 'package:libonthego/Pages/borrow_a_book.dart';

class GetReserveBookUrl extends StatefulWidget {
  const GetReserveBookUrl({super.key, required this.bookID});
  final String bookID;
  @override
  State<GetReserveBookUrl> createState() {
    return _GetReserveBookUrlState();
  }
}

class _GetReserveBookUrlState extends State<GetReserveBookUrl> {
  var message = '';
  var imageURL = '';
  var name = '';
  var edition = '';
  var author = '';
  var bookID = '';
  var borrowPeriod = "14";
  // ignore: non_constant_identifier_names
  int no_of_copies = 0;
  Future<void> getDetails() async {
    final bookData = await FirebaseFirestore.instance
        .collection('books')
        .doc(widget.bookID)
        .get();
    if (bookData.exists) {
      setState(() {
        bookID = bookData['bookID'].toString();
        imageURL = bookData['imageURL'].toString();
        name = bookData['Name'].toString();
        author = bookData['Author'].toString();
        no_of_copies = bookData['NoOfCopies'];
        edition = bookData['Edition'].toString();
      });
    } else {
      setState(() {
        message = 'Invalid Barcode!\nNo such book available!';
      });
    }
  }

  var userId = '';
  void getDataUser() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    setState(() {
      userId = userData.id.toString();
    });
  }

  void _submit() async {
    // Check if the book is already borrowed
    final reservedBooksQuery = await FirebaseFirestore.instance
        .collection('Reserved')
        .where('bookID', isEqualTo: bookID)
        .where('userID', isEqualTo: userId)
        .get();
    final borrowedBooksQuery = await FirebaseFirestore.instance
        .collection('borrowed')
        .where('bookID', isEqualTo: bookID)
        .where('userID', isEqualTo: userId)
        .get();

    if (borrowedBooksQuery.docs.isNotEmpty ||
        reservedBooksQuery.docs.isNotEmpty) {
      // Book is already borrowed, navigate to AlreadyBorrowed page
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AlreadyBorrowed()),
      );
    } else {
      // Book is not already borrowed, proceed with borrowing
      await FirebaseFirestore.instance
          .collection('Reserved')
          .doc('$userId.$bookID')
          .set({
        'userID': userId,
        'bookID': bookID,
        'reserveTime': DateTime.now().add(const Duration(hours: 1)),
        'borrowDate': DateTime.now(),
      });
      await FirebaseFirestore.instance.collection('books').doc(bookID).set({
        'bookID': bookID,
        'Author': author,
        'imageURL': imageURL,
        'Edition': edition,
        'NoOfCopies': (no_of_copies - 1),
        'Name': name,
      });
      //Proceed to Successfully Borrowed Page
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const BorrowABook()));
    }
  }

  @override
  void initState() {
    getDetails();
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve a Book'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/images/DTU.png'), opacity: 0.3)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (imageURL != '')
              Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            width: 100,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  imageURL,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 182,
                          width: 220,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          widget.bookID,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            name,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'Author: $author',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'Edition: $edition',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'No of Copies: $no_of_copies',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    if (imageURL != '')
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          const SizedBox(
                            width: 240,
                          ),
                          TextButton(
                            onPressed: () {
                              _submit();
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.deepPurple[300],
                            ),
                            child: const Text(
                              'Confirm',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            if (message != '')
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
