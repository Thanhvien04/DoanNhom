import 'package:doan/Screen/profile_screen.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key, required this.idx});
  final idx;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}

class _BottomNavState extends State<BottomNav> {
  TextEditingController txt_RoomName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.sailing,
            color: (widget.idx == 0) ? Colors.blue : Colors.grey,
          ),
          label: "Trang chủ",
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: (widget.idx == 1) ? Colors.blue : Colors.grey,
            ),
            label: "Tài khoản"),
      ],
      currentIndex: widget.idx,
      onTap: (int indexOfItem) {
        if (indexOfItem == 0) {
          if (widget.idx != 0) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        }
        if (indexOfItem == 1) {
          if (widget.idx != 1) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Profile_screen()));
          }
        }
      },
    );
  }
}
