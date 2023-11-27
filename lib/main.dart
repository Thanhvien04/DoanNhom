import 'package:doan/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screen/profile.dart';
import 'Screen/setting.dart';
import 'Screen/login_screen.dart';
import 'Screen/signup_screen.dart';
import 'package:doan/login/login.dart';

// cong thanh
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCjpeZ5cng9rlZ-7sbwUiChhsFYfwHXxQs",
          appId: "1:460388309733:android:baf1245a1f9656fd15920c",
          messagingSenderId: "460388309733",
          projectId: "doannhom11-362fa"));
  runApp(const MyApp());
  ChangeNotifierProvider(create: (contex) => logincontroler());
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
        initialRoute: '/',
        routes: {
          // '/': (context) => HomePage(),
          '/profile': (context) => Profile(),
          // '/settings': (context) => SettingsPage(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Signup_interface());
  }
}
