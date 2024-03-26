import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plan_it/screens/auth/login.dart';
import 'package:plan_it/screens/pages/nav_bar.dart';
import 'package:plan_it/theme/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plan IT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColor.containerRed),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return const Navbar();
          } else {
            return const Login();
          }
        },
      ),
    );
  }
}
