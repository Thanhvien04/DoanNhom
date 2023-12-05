import 'package:doan/Screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "asset/nha.png",
                  fit: BoxFit.fitWidth,
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailcontroller,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            filled: true,
                            labelText: "Enter Email",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white.withOpacity(0.3),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                    width: 0,
                                    color: Colors.white,
                                    style: BorderStyle.none)),
                            prefixIcon: const Icon(
                              Icons.person,
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
                                .sendPasswordResetEmail(
                                    email: _emailcontroller.text)
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
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Login_screen()));
                          },
                          child: const Text(
                            'Trở về trang đăng nhập',
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
