import 'dart:async';
import 'package:doan/Screen/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({super.key});

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // ignore: deprecated_member_use
  DatabaseReference database = FirebaseDatabase.instance.reference();
  User? _user;
  String _phoneNumber = '';
  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();

    _getCurrentUser();
    getUserData();
  }

  void _getCurrentUser() {
    _user = auth.currentUser;
  }

  void getUserData() async {
    if (_user != null) {
      String userId = _user!.uid;
      database
          .child('users')
          .child(userId)
          .once()
          .then((DataSnapshot snapshot) {
            if (snapshot.value != null) {
              Map<dynamic, dynamic>? userData = snapshot.value as Map?;

              setState(() {
                _phoneNumber = userData?['phone'];
                _email = userData?['email'];
                _password = userData?['password'];
              });
            } else {
              print('Snapshot is null. User may not be logged in.');
            }
          } as FutureOr Function(DatabaseEvent value));
    }
  }

  hexStringToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  } //hàm màu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        hexStringToColor("CB2B93"),
        hexStringToColor("9546c4"),
        hexStringToColor("5E66F6"),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: _user != null
          ? SingleChildScrollView(
              child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Setting_screen()));
                  },
                  child: const CircleAvatar(
                    radius: 150,
                    backgroundImage: AssetImage("asset/h2.png"),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hexStringToColor("BB3B93"),
                      fixedSize: const Size(double.maxFinite, 50),
                    ),
                    child: Text(
                      '$_phoneNumber',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hexStringToColor("BB3B93"),
                      fixedSize: const Size(double.maxFinite, 50),
                    ),
                    child: Text(
                      ' $_email',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hexStringToColor("BB3B93"),
                      fixedSize: Size(double.maxFinite, 50),
                    ),
                    child: Text(
                      '$_password',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromHeight(50)),
                    child: const Text(
                      "Sign out",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ))
              ],
            ))
          : const CircularProgressIndicator(),
    )));
  }
}
