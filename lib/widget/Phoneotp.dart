import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';

import '../Screen/home_screen.dart';

class Phoneotp extends StatefulWidget {
  const Phoneotp({super.key});

  @override
  State<Phoneotp> createState() => _PhoneotpState();
}

class _PhoneotpState extends State<Phoneotp> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  String verificationIDNhan = '';
  String? otpcode;
  String? kq;
  bool otpcodeVisible = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
            ),
            // TextFormField(
            //   controller: otpController,
            //   keyboardType: TextInputType.phone,
            //   decoration: const InputDecoration(labelText: "Otp"),
            // ),
            const SizedBox(
              height: 30,
            ),
            Visibility(
              visible: otpcodeVisible,
              child: Pinput(
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.purple.shade200)),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                onSubmitted: (value) {
                  otpcode = value;
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (otpcodeVisible) {
                    verifyCode();
                    setState(() {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home_Screen()));
                    });
                  } else {
                    verifyNumber();
                  }
                },
                child: Text(otpcodeVisible == true ? "Login" : "Verify"))
          ],
        ),
      ),
    );
  }

  void verifyNumber() {
    auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth
              .signInWithCredential(credential)
              // ignore: avoid_print
              .then((value) => {print("OK")});
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIDNhan = verificationID;
          otpcodeVisible = true;

          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIDNhan, smsCode: otpController.text);
    print("success");
  }
}
