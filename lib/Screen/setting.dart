import 'dart:io';
import 'package:doan/Screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Setting_screen extends StatefulWidget {
  Setting_screen({super.key});

  @override
  State<Setting_screen> createState() => _Setting_screenState();
}

class _Setting_screenState extends State<Setting_screen> {
  TextEditingController contactEmail = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  File? _imagefile;
  var url;
  var url1;
  ImagePicker image = ImagePicker();
  DatabaseReference? db_ref;
  @override
  void initState() {
    super.initState();
    db_ref = FirebaseDatabase.instance.ref().child('users');
  }

  late User? user = FirebaseAuth.instance.currentUser;
  Future<void> _pickImage(ImageSource gallery) async {
    final pickedFiles =
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFiles != null) {
        _imagefile = File(pickedFiles.path);
      }
    });
  }

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imagefile = File(pickedFile.path);
      });
    }
  }

  bool _obscureText = true;
  hexStringToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546c4"),
            hexStringToColor("5E66F6"),
          ],
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              if (_imagefile != null)
                CircleAvatar(
                  radius: 120,
                  backgroundImage: FileImage((_imagefile!)),
                )
              else
                const CircleAvatar(
                  radius: 120,
                  backgroundImage: AssetImage('asset/h2.jpg'),
                ),
              ElevatedButton(
                  child: const Text(
                    "Change",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Row(children: []),
                            content: Row(children: [
                              ElevatedButton(
                                  onPressed: () =>
                                      _pickImage(ImageSource.gallery),
                                  child: const Row(children: [
                                    Icon(
                                      Icons.library_add,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      ' Album',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ])),
                              const SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () => _pickImageFromCamera(),
                                  child: const Row(children: [
                                    Icon(
                                      Icons.camera_alt,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      ' Camera',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ])),
                            ]),
                            actions: <Widget>[
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
                            ],
                          );
                        });
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  controller: contactEmail,
                  decoration: InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              width: 1,
                              color: Colors.black,
                              style: BorderStyle.none)),
                      prefixIcon: const Icon(
                        Icons.phone_android,
                        color: Colors.black,
                      ))),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _password,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "Password...",
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                          width: 1,
                          color: Colors.black,
                          style: BorderStyle.none)),
                  prefixIcon: const Icon(
                    Icons.lock_open,
                    color: Colors.black,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _phone,
                decoration: InputDecoration(
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            width: 1,
                            color: Colors.black,
                            style: BorderStyle.none)),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.black,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Row(children: [
                const Padding(padding: EdgeInsets.all(30)),
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
                                "Are you sure about this change ?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              actions: <Widget>[
                                Row(children: [
                                  const Padding(padding: EdgeInsets.all(10)),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Profile_screen()));
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
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white70),
                    ),
                    child: const Text(
                      "Update",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 17),
                    )),
                const Padding(padding: EdgeInsets.all(20)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Profile_screen(),
                        ),
                      );
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white70),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 17),
                    ))
              ])),
            ],
          ),
        ),
      ),
    )));
  }
}