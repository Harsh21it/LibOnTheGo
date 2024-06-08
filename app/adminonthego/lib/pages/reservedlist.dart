import 'package:adminonthego/pages/navbar.dart';
import 'package:adminonthego/pages/reservelist.dart';
import 'package:flutter/material.dart';

class ReservedBooks extends StatefulWidget {
  const ReservedBooks({super.key, required this.userId});
  final String userId;
  @override
  State<ReservedBooks> createState() => _ReservedBooksState();
}

class _ReservedBooksState extends State<ReservedBooks> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrowed Books'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/images/DTU.png'), opacity: 0.3)),
        child: ReservedList(userId: widget.userId),
      ),
      bottomNavigationBar: const NavigatorBar(),
    );
  }
}
