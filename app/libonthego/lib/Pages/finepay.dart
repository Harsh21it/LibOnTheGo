import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libonthego/Pages/navigator_bar.dart';
import 'package:libonthego/Pages/user_page.dart';

class FinePay extends StatefulWidget {
  const FinePay({Key? key}) : super(key: key);

  @override
  State<FinePay> createState() {
    return _FinePayState();
  }
}

class _FinePayState extends State<FinePay> {
  var userImageURL = '';
  var username = '';
  int totalfine = 0; // Define totalFine variable outside of the function

  Future<void> calculateFine(String userId) async {
    final QuerySnapshot borrowedBooksQuery = await FirebaseFirestore.instance
        .collection('borrowed')
        .where('userID', isEqualTo: userId)
        .get();

    DateTime currentDate = DateTime.now();

    for (QueryDocumentSnapshot borrowedBook in borrowedBooksQuery.docs) {
      DateTime returnTillDate = borrowedBook['returnTillDate'].toDate();
      // print(returnTillDate);
      if (currentDate.isAfter(returnTillDate)) {
        int overdueDays = currentDate.difference(returnTillDate).inDays;
        // print(overdueDays);
        int fineForBook = overdueDays * 5; // $5 per day per book
        int totalFine = 0;
        totalFine += fineForBook;
        setState(() {
          totalfine = totalFine;
        });
      }
    }
  }

  var userId = '';

  void getData() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    setState(() {
      userId = userData.id;
      userImageURL = userData.data()!['imageUrl'].toString();
    });

    await calculateFine(
        userId); // Call calculateFine function after fetching user data
    // print('Total Fine: $totalfine'); // Print total fine for testing
  }

  @override
  void initState() {
    super.initState();
    getData();
    calculateFine(userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/images/DTU.jpg'), opacity: 0.4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                title: const Text('Fine'),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 100,
                      child: Image.asset('assets/images/Icon.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 120,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
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
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: SizedBox(
                    height: 40,
                    child: Text(
                      'Your Fine is: $totalfine Rs',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 32.0),
                  child: SizedBox(
                    height: 60,
                    child: Text(
                      'Pay using the following methods:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 160,
                      child: Image.asset('assets/images/BHIMUPI.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 160,
                      child: Image.asset('assets/images/CARDS.png'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 160,
                      child: Image.asset('assets/images/NETBANKING.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 180,
                      child: Image.asset('assets/images/FRONTDESK.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavigatorBar(),
    );
  }
}
