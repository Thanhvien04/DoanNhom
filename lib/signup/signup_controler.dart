import 'package:doan/servers/session.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Signupcontronler with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('users');
  bool _loading = false;
  bool get loading => _loading;
  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> signup(
      BuildContext context, String email, String password, String phone) async {
    setloading(true);
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        ref.child(value.user!.uid).set({
          'email': email,
          'phone': phone,
          'password': password
          //'image': " ",
        }).then((value) {
          setloading(false);
          print("khong");
        }).onError((error, stackTrace) {
          setloading(false);
        });
        Sesion().userId = value.user?.uid;
        setloading(false);
      });
    } catch (e) {
      setloading(false);
      print("khong");
    }
  }
}
