import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.idx});
  final idx;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.sailing,
            color: (idx == 0) ? Colors.blue : Colors.grey,
          ),
          label: "Trang chủ",
        ),
        BottomNavigationBarItem(
          icon: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              color: Colors.blue,
              child: const Icon(
                Icons.add,
              ),
            ),
          ),
          label: "Thêm",
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: (idx == 1) ? Colors.blue : Colors.grey,
            ),
            label: "Tài khoản"),
      ],
      currentIndex: idx,
      onTap: (int indexOfItem) {
        if (indexOfItem == 0) {
          if (idx != 0) {
            Navigator.popUntil(context, (route) => route.isFirst);
            //Navigator.pushNamed(context, '/');
          }
        }
        if (indexOfItem == 2) {
          if (idx != 1) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushNamed(context, '/profile');
          }
        }
      },
    );
  }
}
