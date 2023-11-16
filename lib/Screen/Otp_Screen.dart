import 'package:doan/login_interface.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var otpcode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Center(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage("asset/nha.png"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Verification",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter the OTP send to your phone number",
                style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Pinput(
            length: 6,
            showCursor: true,
            defaultPinTheme: PinTheme(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.purple.shade200)),
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            onSubmitted: (value) {
              otpcode = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              width: 400,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Đăng Ký Thành Công'),
                          icon: const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 50,
                          ),
                          actions: [
                            Container(
                              width: 300,
                              height: 50,
                              child: FloatingActionButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Login_interface()));
                                },
                                backgroundColor: Colors.purple,
                                child: const Text(
                                  "Đăng Nhập",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            )
                          ],
                        );
                      });
                },
                child: Text(
                  "Verify",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              )),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "didn't receive any code ?",
                style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const InkWell(
            child: Text(
              "Resend new code",
              style: TextStyle(
                  color: Colors.purple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
