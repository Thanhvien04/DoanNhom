import 'dart:io';

<<<<<<< HEAD
import 'package:doan/Screen/home_screen.dart';
import 'package:doan/login/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:doan/until/until.dart';
import 'package:provider/provider.dart';
=======
import 'package:doan/Screen/phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

>>>>>>> e95a4e74d974468af9b2d3a3b31f4fd830670fe7
import 'login_screen.dart';

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

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // ignore: unused_field
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String kq = '';
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
<<<<<<< HEAD
  final emailNode = FocusNode();
  final paswordnode = FocusNode();
  final phoneNode = FocusNode();
  File? _image = File('asset/h2.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546c4"),
              hexStringToColor("5E66F6"),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                // child: ChangeNotifierProvider(
                //     create: (_) => Signupcontronler(),
                //     child: Consumer<Signupcontronler>(
                //         builder: (context, provider, child) {
                child: SingleChildScrollView(
                    child:
                        //  key: _formkey,
                        Column(children: [
                  Image.asset(
                    "asset/h1.png",
                    fit: BoxFit.fitWidth,
                    height: 300,
                    width: 500,
=======
  final File _image = File('asset/h2.jpg');
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
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailcontroller.text,
                        password: _passwordcontroller.text,
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyPhone()));
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
                                  builder: (context) => const Login_screen()));
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
>>>>>>> e95a4e74d974468af9b2d3a3b31f4fd830670fe7
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
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _emailcontroller.text,
                          password: _passwordcontroller.text,
                        );
                        _registerAndSaveToRealtimeDatabase();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home_Screen()));
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
                          ]))
                ])))));
  }
<<<<<<< HEAD

  void _registerAndSaveToRealtimeDatabase() {
    String phone = _phonecontroller.text;
    String email = _emailcontroller.text;
    String password = _passwordcontroller.text;
    String? image = _image?.path;

    try {
      DatabaseReference databaseReference =
          // ignore: deprecated_member_use
          FirebaseDatabase.instance.reference();

      databaseReference.child('users').push().set({
        'phone': phone,
        'email': email,
        'password': password,
        'image': image
      });

      print('Dữ liệu đã được gửi lên Realtime Database');
    } catch (e) {
      print('Lỗi khi gửi dữ liệu lên Realtime Database: $e');
    }
  }
}
//                 Padding(
//                   padding: const EdgeInsets.only(right: 30, top: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Image.asset(
//                         "asset/h1.jpg",
//                         fit: BoxFit.fitWidth,
//                         height: 300,
//                         width: 500,
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextFormField(
//                         controller: _phonecontroller,
//                         focusNode: phoneNode,
//                         cursorColor: Colors.white,
//                         decoration: InputDecoration(
//                             filled: true,
//                             labelText: "Enter Phone",
//                             floatingLabelBehavior: FloatingLabelBehavior.never,
//                             labelStyle:
//                                 TextStyle(color: Colors.white.withOpacity(0.9)),
//                             fillColor: Colors.white.withOpacity(0.3),
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(30.0),
//                                 borderSide: const BorderSide(
//                                     width: 0,
//                                     color: Colors.white,
//                                     style: BorderStyle.none)),
//                             prefixIcon: const Icon(
//                               Icons.person,
//                               color: Colors.white70,
//                             )),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextFormField(
//                         controller: _emailcontroller,
//                         focusNode: emailNode,
//                         cursorColor: Colors.white,
//                         onFieldSubmitted: (value) {
//                           untils.fildFocus(context, emailNode, paswordnode);
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const Login_screen()));
//                         },
//                         decoration: InputDecoration(
//                             filled: true,
//                             labelText: "Enter Email",
//                             floatingLabelBehavior: FloatingLabelBehavior.never,
//                             labelStyle:
//                                 TextStyle(color: Colors.white.withOpacity(0.9)),
//                             fillColor: Colors.white.withOpacity(0.3),
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(30.0),
//                                 borderSide: const BorderSide(
//                                     width: 0,
//                                     color: Colors.white,
//                                     style: BorderStyle.none)),
//                             prefixIcon: const Icon(
//                               Icons.person,
//                               color: Colors.white70,
//                             )),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextFormField(
//                         controller: _passwordcontroller,
//                         focusNode: paswordnode,
//                         cursorColor: Colors.white,
//                         decoration: InputDecoration(
//                             filled: true,
//                             labelText: "Enter Password",
//                             floatingLabelBehavior: FloatingLabelBehavior.never,
//                             labelStyle:
//                                 TextStyle(color: Colors.white.withOpacity(0.9)),
//                             fillColor: Colors.white.withOpacity(0.3),
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(30.0),
//                                 borderSide: const BorderSide(
//                                     width: 0,
//                                     color: Colors.white,
//                                     style: BorderStyle.none)),
//                             prefixIcon: const Icon(
//                               Icons.person,
//                               color: Colors.white70,
//                             )),
//                       ),
//                       Text(
//                         kq,
//                         style: const TextStyle(
//                             fontSize: 16,
//                             color: Colors.red,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       ElevatedButton(
//                           style: const ButtonStyle(
//                               backgroundColor:
//                                   MaterialStatePropertyAll(Colors.white70)),
//                           onPressed: () {
//                             FirebaseAuth.instance
//                                 .createUserWithEmailAndPassword(
//                               email: _emailcontroller.text,
//                               password: _passwordcontroller.text,
//                             );
//                             _registerAndSaveToRealtimeDatabase();
//                             // if (_formkey.currentState!.validate()) {
//                             //   provider.signup(
//                             //       context,
//                             //       _phonecontroller.text,
//                             //       _emailcontroller.text,
//                             //       _passwordcontroller.text);
//                             // }
//                             {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Login_interface()));
//                             }
//                             ;
//                           },
//                           child: const Text(
//                             "Sign Up",
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red),
//                           )),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 30, top: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             const Text(
//                               "Do you have an accout ?",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             Login_interface()));
//                               },
//                               child: RichText(
//                                 text: const TextSpan(
//                                     text: "Log in",
//                                     style: TextStyle(
//                                         color: Colors.red,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16)),
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ))));
//   }

 
=======
}
>>>>>>> e95a4e74d974468af9b2d3a3b31f4fd830670fe7
