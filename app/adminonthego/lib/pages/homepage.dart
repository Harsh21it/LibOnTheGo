import 'package:adminonthego/pages/books.dart';
import 'package:adminonthego/pages/studentdetails.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(
              'assets/images/DTU.png',
            ),
            opacity: 0.4,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: 180,
                    child: Text(
                      'Hello Admin!\nWelcome to LibOnTheGo',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    'assets/images/Icon.png',
                    width: 140,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 5),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/books.jpg'),
                          fit: BoxFit.cover,
                          opacity: 0.8)),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 40, 4, 40),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Students()));
                                  },
                                  icon: Container(
                                    height: 150,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black, width: 5),
                                      borderRadius: BorderRadius.circular(15),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/book1.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          'Students',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Books()));
                                  },
                                  icon: Container(
                                    height: 150,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black, width: 5),
                                      borderRadius: BorderRadius.circular(15),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/borrowedbooks.jpg'),
                                          fit: BoxFit.cover),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text(
                                        'Books',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
