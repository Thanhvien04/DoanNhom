import 'package:doan/until/until.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:doan/servers/session.dart';
import 'package:provider/provider.dart';

class logincontroler with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;

  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void login(BuildContext context, String email, String password) async {
    setloading(true);
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Sesion().userId = value.user?.uid.toString() ?? "";

        setloading(false);
      });
    } catch (e) {
      print("error");
      setloading(false);
    }
  }
}
