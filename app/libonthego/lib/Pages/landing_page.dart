import 'package:flutter/material.dart';

const startAlignment = Alignment.topCenter;
const endAlignment = Alignment.bottomCenter;

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(234, 198, 85, 65),
        Color.fromARGB(255, 252, 211, 211),
        Color.fromARGB(215, 226, 17, 17)
      ], begin: startAlignment, end: endAlignment)),
      child: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 250,
          ),
          Image.asset('assets/images/Icon.png'),
          const Text(
            "Welcome To LibOnTheGo",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color.fromARGB(255, 3, 3, 3)),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      )),
    );
  }
}
