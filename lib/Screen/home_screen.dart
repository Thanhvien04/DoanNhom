import 'package:doan/widget/DefaultTabController.dart';
import 'package:doan/widget/bottomnaviga.dart';
import 'package:flutter/material.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

bool _isExpanded = true;

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Trang chủ'),
          backgroundColor: Colors.blue,
        ),
        bottomNavigationBar: const BottomNav(
          idx: 0,
        ),
        body: const defaultTabController());
  }
}
