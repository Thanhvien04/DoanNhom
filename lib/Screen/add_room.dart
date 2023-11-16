import 'package:flutter/material.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({super.key});

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  TextEditingController txt_roomname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Thêm phòng'),
          backgroundColor: Colors.blue,
        ),
        body: const Column(
          children: [
            TextField(

            )
          ],
        ));
  }
}
