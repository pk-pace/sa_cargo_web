import 'package:flutter/material.dart';
import 'package:sa_cargo_web/screens/home/home_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'sacargo',
      options: const FirebaseOptions(
          apiKey: "AIzaSyCsW62IfbR5e4H7r3dAOiwKegSMVtGW0h0",
          appId: "1:653285182737:android:832377a773528ea27710b0",
          messagingSenderId: "",
          projectId: "sa-cargo-services-d878d"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SA Cargo Portal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
