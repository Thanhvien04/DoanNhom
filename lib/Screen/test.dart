import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  bool isDeleteButtonVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            isDeleteButtonVisible = true;
            print("nhấn");
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Xử lý sự kiện nhấn button
                setState(() {
                  isDeleteButtonVisible = false;
                });
              },
              child: const Text("Button"),
            ),
            if (isDeleteButtonVisible)
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delete),
              ),
          ],
        ),
      ),
    );
  }
}
