import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      appBar: AppBar(
        title: const Center(
          child: Text("Profile",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
        ),
        backgroundColor: Colors.blue,
      ),
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
            const CircleAvatar(
              radius: 120,
              backgroundImage: AssetImage("asset/nha.png"),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  fixedSize: Size(double.maxFinite, 50),
                ),
                child: const Text(
                  "Username",
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  fixedSize: Size(double.maxFinite, 50),
                ),
                child: const Text(
                  "Phone",
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  fixedSize: Size(double.maxFinite, 50),
                ),
                child: const Text(
                  "Password",
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
            const SizedBox(
              height: 30,
            ),
          ],
        )),
      ), //mã màu,
    );
  }
}
