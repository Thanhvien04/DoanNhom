import 'dart:ui';
import '../widget/bottomnaviga.dart';
import 'login_screen.dart';
import 'package:flutter/material.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({super.key});

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
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
      bottomNavigationBar: const BottomNav(
        idx: 1,
      ),

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
                          builder: (context) => const Login_screen()));
                },
                child: const CircleAvatar(
                  radius: 150,
                  backgroundImage: AssetImage("asset/nha.png"),
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
                  child: const Text(
                    "Username",
                    style: TextStyle(
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
                  child: const Text(
                    "Phone",
                    style: TextStyle(
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
                  child: const Text(
                    "Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
            ],
          )),
        ),
      ), //mã màu,
    );
  }
}
