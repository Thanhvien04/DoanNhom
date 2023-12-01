import 'dart:io';

import 'package:doan/Screen/phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'otp_screen.dart';

class Signup_screen extends StatefulWidget {
  const Signup_screen({super.key});

  @override
  State<Signup_screen> createState() => _Signup_screenState();
}

class _Signup_screenState extends State<Signup_screen> {
  hexStringToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String kq = '';
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _username = TextEditingController();
  File? _image = File('asset/h2.jpg');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: Column(
                children: [
                  Image.asset(
                    "asset/h1.png",
                    fit: BoxFit.fitWidth,
                    height: 300,
                    width: 500,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _username,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        filled: true,
                        labelText: "User name",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle:
                            TextStyle(color: Colors.white.withOpacity(0.9)),
                        fillColor: Colors.white.withOpacity(0.3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                width: 0,
                                color: Colors.white,
                                style: BorderStyle.none)),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.white70,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailcontroller,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        filled: true,
                        labelText: "Enter Email",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle:
                            TextStyle(color: Colors.white.withOpacity(0.9)),
                        fillColor: Colors.white.withOpacity(0.3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                width: 0,
                                color: Colors.white,
                                style: BorderStyle.none)),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white70,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordcontroller,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        filled: true,
                        labelText: "Enter Password",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle:
                            TextStyle(color: Colors.white.withOpacity(0.9)),
                        fillColor: Colors.white.withOpacity(0.3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                width: 0,
                                color: Colors.white,
                                style: BorderStyle.none)),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.white70,
                        )),
                  ),
                  Text(
                    kq,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white70)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login_screen()));
                        if (_emailcontroller.text.isEmpty ||
                            _passwordcontroller.text.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                      'Vui lòng nhập đầy đủ thông tin'),
                                  icon: const Icon(
                                    Icons.warning,
                                    color: Colors.yellow,
                                    size: 50,
                                  ),
                                  actions: [
                                    SizedBox(
                                      width: 300,
                                      height: 50,
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Signup_screen()));
                                        },
                                        backgroundColor: Colors.purple,
                                        child: const Text(
                                          "Ok",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              });
                        } else {
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _emailcontroller.text,
                            password: _passwordcontroller.text,
                          ).then((value) {
                          FirebaseAuth.instance.currentUser
                              ?.updateDisplayName(_username.text);
                          print("Created new account");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>const Login_screen()));
                        }).onError((error, stackTrace) {
                          print("Error ${error.toString()}");
                        });;
                        }
                        //  FirebaseAuth.instance
                        //      .createUserWithEmailAndPassword(
                        //    email: _emailcontroller.text,
                        //    password: _passwordcontroller.text,
                        //  )
                            
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Do you have an accout ?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login_screen()));
                          },
                          child: RichText(
                            text: const TextSpan(
                                text: "Log in",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}