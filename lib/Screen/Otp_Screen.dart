import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_screen.dart';

class Login_interface extends StatefulWidget {
  const Login_interface({super.key});

  @override
  State<Login_interface> createState() => _Login_interfaceState();
}

bool _obscureText = true;

class _Login_interfaceState extends State<Login_interface> {
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found that email");
      }
    }
    return user;
  }

  String value = '';
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  hexStringToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

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
                  height: 350,
                  width: 500,
                ),
                TextFormField(
                  controller: _email,
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
                  obscureText: true,
                  controller: _password,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: "Enter Password",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
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
                Text(
                  value,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white70)),
                    onPressed: () async {
                      User? user = await loginUsingEmailPassword(
                          email: _email.text,
                          password: _password.text,
                          context: context);
                      print(user);
                      if (user != null) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Home_Screen()));
                      } else {
                        setState(() {
                          value = "Username or Password not Invalible !!";
                        });
                        print("Username or Password not Invalible !!");
                      }
                      ;
                    },
                    child: const Text(
                      "Login",
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
                                  builder: (context) => Signup_interface()));
                        },
                        child: RichText(
                          text: const TextSpan(
                              text: "Sign up",
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
