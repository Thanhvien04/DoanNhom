import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

class ForgetPassword_Screen extends StatefulWidget {
  const ForgetPassword_Screen({super.key});

  @override
  State<ForgetPassword_Screen> createState() => _ForgetPassword_ScreenState();
}

class _ForgetPassword_ScreenState extends State<ForgetPassword_Screen> {
  hexStringToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  String kq = '';
  final TextEditingController _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "asset/nha.png",
                  fit: BoxFit.fitWidth,
                  height: 300,
                  width: 500,
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
                        Icons.person,
                        color: Colors.white70,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white70)),
                    onPressed: () {
                      FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailcontroller.text)
                      .then((value) => Navigator.of(context).pop());
                    },
                    child: const Text(
                      "Forget Password",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    )),
                Text(
                  kq,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}