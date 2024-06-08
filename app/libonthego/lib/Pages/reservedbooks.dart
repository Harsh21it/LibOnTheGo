import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libonthego/Pages/navigator_bar.dart';
import 'package:libonthego/Pages/reservedbookslist.dart';
import 'package:libonthego/Pages/user_page.dart';

class ReservedBooks extends StatefulWidget {
  const ReservedBooks({Key? key}) : super(key: key);

  @override
  State<ReservedBooks> createState() => _ReservedBooksState();
}

class _ReservedBooksState extends State<ReservedBooks> {
  var userImageURL = '';
  var userId = '';

  void getData() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    setState(() {
      userImageURL = userData.data()!['imageUrl'].toString();
      userId = userData.id.toString();
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
        title: const Text('Reserved Books'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/images/DTU.png'), opacity: 0.3)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 50),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    child: Image.asset('assets/images/Icon.png'),
                  ),
                ),
                const SizedBox(width: 60),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserPage()),
                      );
                    },
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
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
            const Expanded(
              child: Column(
                children: [
                  SizedBox(height: 500, child: ReservedBookList()),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavigatorBar(),
    );
  }
}
