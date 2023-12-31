import 'package:doan/Screen/phone.dart';
import 'package:flutter/material.dart';
import 'forget_screen.dart';
import 'home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_screen.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({super.key});

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

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

  bool isObscureText = true;
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
                Image.asset("asset/nha.png",
                    fit: BoxFit.fitWidth,
                    height: 250,
                    width: MediaQuery.of(context).size.width),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _email,
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
                      TextFormField(
                        obscureText: isObscureText,
                        controller: _password,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            suffixIcon: isObscureText
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscureText = !isObscureText;
                                      });
                                    },
                                    icon: const Icon(Icons.visibility_off))
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscureText = !isObscureText;
                                      });
                                    },
                                    icon: const Icon(Icons.visibility)),
                            filled: true,
                            labelText: "Enter Password",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white.withOpacity(0.3),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                    width: 0,
                                    color: Colors.white,
                                    style: BorderStyle.none)),
                            prefixIcon: const Icon(
                              Icons.lock,
                            )),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        value,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 1,
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
                            print("$_email");
                            print("$_password");
                            if (user != null) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Home_Screen()));
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
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyPhone()));
                        },
                        child: const Text(
                          "Log in with SMS",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      forgetPassword(context),
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
                                        builder: (context) =>
                                            const Signup_screen()));
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 20,
        alignment: Alignment.bottomRight,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgetPassword_Screen()));
          },
          child: RichText(
            text: const TextSpan(
                text: "Forget Password",
                style: TextStyle(
                    color: Colors.redAccent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                    decorationStyle: TextDecorationStyle.solid,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ),
        ));
  }
}
