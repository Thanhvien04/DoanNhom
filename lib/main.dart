<<<<<<< HEAD
=======
import 'package:doan/Screen/Otp_Screen.dart';
import 'package:doan/Screen/home_screen.dart';
>>>>>>> c56247823e975928df0bdd62a155922a8f5afebb
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screen/profile.dart';
import 'Screen/login_screen.dart';

////vien
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCjpeZ5cng9rlZ-7sbwUiChhsFYfwHXxQs",
          appId: "1:460388309733:android:baf1245a1f9656fd15920c",
          messagingSenderId: "460388309733",
          projectId: "doannhom11-362fa"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Profile());
  }
}
