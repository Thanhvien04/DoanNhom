import 'dart:async';
import 'package:doan/Screen/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../widget/bottomnaviga.dart';
import 'login_screen.dart';
import 'package:flutter/material.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({super.key});

  @override
  State<Profile_screen> createState() => _ProfileState();
}

class _ProfileState extends State<Profile_screen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? _user;
  String? name = FirebaseAuth.instance.currentUser!.displayName;
  String? _phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
  String? _email = FirebaseAuth.instance.currentUser!.email;
  void signOut() async {
    try {
      await auth.signOut();
      print("Đăng xuất thành công");
    } catch (e) {
      print("Lỗi khi đăng xuất: $e");
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
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:const BottomNav(idx: 1,),
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                hexStringToColor("CB2B93"),
                hexStringToColor("9546c4"),
                hexStringToColor("5E66F6"),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: SingleChildScrollView(
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
                         '$name',
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
                         '$_email',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Row(children: [
                                  Icon(
                                    Icons.warning_amber,
                                    color: Colors.redAccent,
                                  ),
                                  Text(
                                    " Warning!",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ]),
                                content: const Text(
                                  "Do you really want to be exported?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                actions: <Widget>[
                                  Row(children: [
                                    const Padding(padding: EdgeInsets.all(10)),
                                    TextButton(
                                        onPressed: () {
                                          signOut();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Login_screen()));
                                        },
                                        child: const Text(
                                          "Ok",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    const Padding(padding: EdgeInsets.all(25)),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Close',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ])
                                ],
                              );
                            });
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(50)),
                      child: const Text(
                        "Sign out",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))
                ],
              )))),
    );
  }
}