import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libonthego/Pages/borrow_or_reserve.dart';
import 'package:libonthego/Pages/borrowed_books.dart';
import 'package:libonthego/Pages/finepay.dart';
import 'package:libonthego/Pages/user_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() {
    return _MenuPageState();
  }
}

class _MenuPageState extends State<MenuPage> {
  var userName = '';
  var userImageURL = '';

  void getData() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    setState(() {
      userName = userData.data()!['username'].toString();
      userImageURL = userData.data()!['imageUrl'].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/images/DTU.png'), opacity: 0.8),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserPage()));
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              userImageURL,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Hi $userName!',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        child: Container(
                          height: 150,
                          width: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/books.jpg'),
                                  fit: BoxFit.cover,
                                  opacity: 0.7),
                              border: const Border.symmetric(
                                  horizontal:
                                      BorderSide(color: Colors.black, width: 2),
                                  vertical: BorderSide(
                                      color: Colors.black, width: 2))),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BorrowOrReserve()));
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Borrow a book',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 25)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        child: Container(
                          height: 150,
                          width: 160,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage('assets/images/Fine.jpg'),
                                fit: BoxFit.cover,
                                opacity: 0.4),
                            border: const Border.symmetric(
                                horizontal:
                                    BorderSide(color: Colors.black, width: 2),
                                vertical:
                                    BorderSide(color: Colors.black, width: 2)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FinePay()));
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Check for fine',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 25)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        child: Container(
                          height: 150,
                          width: 160,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/borrowedbooks.jpg'),
                                fit: BoxFit.cover,
                                opacity: 0.4),
                            border: const Border.symmetric(
                                horizontal:
                                    BorderSide(color: Colors.black, width: 2),
                                vertical:
                                    BorderSide(color: Colors.black, width: 2)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BorrowedBooks()));
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Borrowed Books',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 25)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        child: Container(
                          height: 150,
                          width: 160,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage('assets/images/user.png'),
                                fit: BoxFit.fitWidth,
                                opacity: 0.4),
                            border: const Border.symmetric(
                                horizontal:
                                    BorderSide(color: Colors.black, width: 2),
                                vertical:
                                    BorderSide(color: Colors.black, width: 2)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const UserPage()));
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('User Details',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 25)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
