import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_interface.dart';
import 'package:firebase_core/firebase_core.dart';

class Signup_interface extends StatefulWidget {
  const Signup_interface({super.key});

  @override
  State<Signup_interface> createState() => _Signup_interfaceState();
}

class _Signup_interfaceState extends State<Signup_interface> {
  hexStringToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  String kq = '';
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

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
                  controller: _phonecontroller,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: "Enter Phone",
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
                        Icons.person,
                        color: Colors.white70,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
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
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailcontroller.text,
                        password: _passwordcontroller.text,
                      );
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
                                  builder: (context) => Login_interface()));
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
    );
  }
}
