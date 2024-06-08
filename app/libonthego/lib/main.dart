import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libonthego/Pages/form_fill.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:libonthego/Pages/home_page.dart';
import 'package:libonthego/Pages/landing_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/images/DTU.png'), opacity: 0.3)),
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const GradientContainer();
              }
              if (snapshot.hasData) {
                return const HomePage();
              }
              return const FormFill();
            }),
          ),
        ),
      ),
    ),
  );
}
