import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_ecommerce_155e5/Presentation/Intro_screen.dart';
import 'package:flutter_ecommerce_155e5/demo_for_today.dart';
import 'package:flutter_ecommerce_155e5/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //       storageBucket: "gs://flutter-ecommerce-155e5.appspot.com",
  //       apiKey: "AIzaSyBVTP3KjFb4cX89cd3GeleEj4f7I0u4Mik",
  //       appId: "1:63526754925:android:585bc99fcff6b1ae04fd64",
  //       messagingSenderId: "63526754925",
  //       projectId: "flutter-ecommerce-155e5"),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bangalicious Story',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home:
          //  const AdminHomePage()
          //  AdminHomePage(),
          // setData(),
          (FirebaseAuth.instance.currentUser == null)
              ? const Intro()
              : const DemoForToday(),
    );
  }
}
