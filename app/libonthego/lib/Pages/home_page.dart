import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libonthego/Pages/borrow_or_reserve.dart';
import 'package:libonthego/Pages/borrowed_books.dart';
import 'package:libonthego/Pages/finepay.dart';
import 'package:libonthego/Pages/navigator_bar.dart';
import 'package:libonthego/Pages/reservedBooks.dart';
import 'package:libonthego/Pages/user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
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
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/DTU.jpg'), opacity: 0.4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                title: const Text('Home'),
                actions: [
                  IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 150,
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Image.asset(
                          'assets/images/Icon.png',
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserPage()));
                          },
                          child: Container(
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
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 60,
                  child: Text(
                    'Hi $userName',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 35,
                        color: Colors.black),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 40,
                  child: Text(
                    'Welcome to LIBONTHEGO',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 50),
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
                  ]),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  child: Container(
                    height: 90,
                    width: 335,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/images/borrowedbooks.jpg'),
                          fit: BoxFit.cover,
                          opacity: 0.7),
                      border: const Border.symmetric(
                          horizontal: BorderSide(color: Colors.black, width: 2),
                          vertical: BorderSide(color: Colors.black, width: 2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BorrowedBooks()));
                      },
                      child: const Text('Borrowed Books',
                          style:
                              TextStyle(color: Colors.black87, fontSize: 25)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  child: Container(
                    height: 90,
                    width: 335,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/images/bookreserved.jpg'),
                          fit: BoxFit.cover,
                          opacity: 0.7),
                      border: const Border.symmetric(
                          horizontal: BorderSide(color: Colors.black, width: 2),
                          vertical: BorderSide(color: Colors.black, width: 2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ReservedBooks()));
                      },
                      child: const Text('Reserved Books',
                          style: TextStyle(color: Colors.black, fontSize: 25)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavigatorBar(),
    );
  }
}
