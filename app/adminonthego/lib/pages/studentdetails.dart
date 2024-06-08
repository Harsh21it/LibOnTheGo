import 'package:adminonthego/pages/navbar.dart';
import 'package:adminonthego/pages/students.dart';
import 'package:flutter/material.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StudentsState();
  }
}

class _StudentsState extends State<Students> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      bottomNavigationBar: const NavigatorBar(),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(
              'assets/images/DTU.png',
            ),
            opacity: 0.4,
          ),
        ),
        child: const StudentDetails(),
      ),
    );
  }
}
