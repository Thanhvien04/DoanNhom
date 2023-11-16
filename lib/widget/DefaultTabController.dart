import 'dart:math';

import 'package:doan/models/device.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/room.dart';

class defaultTabController extends StatefulWidget {
  const defaultTabController({super.key});

  @override
  State<defaultTabController> createState() => _defaultTabControllerState();
}

List<Device> lst_device = [
  Device(id: 1, stt: false, name: 'Đèn', img: 'asset/light.png', id_room: 1),
  Device(id: 2, stt: false, name: 'Đèn', img: 'asset/light.png', id_room: 1),
  Device(id: 1, stt: false, name: 'Quạt', img: 'asset/fan.png', id_room: 2),
  Device(id: 2, stt: false, name: 'Quạt', img: 'asset/fan.png', id_room: 2),
  Device(id: 1, stt: true, name: 'Đèn', img: 'asset/light.png', id_room: 3),
  Device(id: 2, stt: true, name: 'Đèn', img: 'asset/light.png', id_room: 3),
  Device(id: 1, stt: true, name: 'Quạt', img: 'asset/fan.png', id_room: 4),
  Device(id: 2, stt: true, name: 'Quạt', img: 'asset/fan.png', id_room: 4),
];
List<Device> lst_device_bedroom = [];
List<Device> lst_device_livingroom = [];
List<Device> lst_device_bathroom = [];
List<Device> lst_device_kitchen = [];
bool stt_build_fisrt = false;

class _defaultTabControllerState extends State<defaultTabController> {
  bool switchValue = true;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 2;
    var height = MediaQuery.of(context).size.height;
    hexStringToColor(String hexColor) {
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }
      return Color(int.parse(hexColor, radix: 16));
    }

    if (!stt_build_fisrt) {
      for (int i = 0; i < lst_device.length; i++) {
        if (lst_device[i].id_room == 1) {
          lst_device_livingroom.add(lst_device[i]);
        }
      }
      for (int i = 0; i < lst_device.length; i++) {
        if (lst_device[i].id_room == 2) {
          lst_device_kitchen.add(lst_device[i]);
        }
      }
      for (int i = 0; i < lst_device.length; i++) {
        if (lst_device[i].id_room == 3) {
          lst_device_bedroom.add(lst_device[i]);
        }
      }
      for (int i = 0; i < lst_device.length; i++) {
        if (lst_device[i].id_room == 4) {
          lst_device_bathroom.add(lst_device[i]);
        }
      }
      stt_build_fisrt = true;
    }
    List<Room> lstRoom = [
      Room(id: 1, lstDevice: lst_device_livingroom, name: 'Phòng khách'),
      Room(id: 2, lstDevice: lst_device_kitchen, name: 'Phòng bếp'),
      Room(id: 3, lstDevice: lst_device_bedroom, name: 'Phòng ngủ'),
      Room(id: 4, lstDevice: lst_device_bathroom, name: 'Phòng tắm'),
    ];
    return DefaultTabController(
        length: lstRoom.length,
        child: Column(children: [
          TabBar(
            tabs: lstRoom.map((e) => Text(e.name)).toList(),
            isScrollable: true,
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546c4"),
              hexStringToColor("5E66F6"),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            height: 300,
            child: TabBarView(children: [
              room(lstRoom[0]),
              room(lstRoom[1]),
              room(lstRoom[2]),
              room(lstRoom[3]),
            ]),
          )
        ]));
  }

  Column room(Room room) {
    return Column(children: [
      Row(children: room.lstDevice.map((e) => device(e)).toList())
    ]);
  }

  Container device(Device device) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: 150,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white38),
        child: TextButton(
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: switchValue ? Colors.white70 : Colors.transparent,
                  ),
                  child: Image.asset(
                    device.img,
                    height: 65,
                  )),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      device.name,
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  )),
                  CupertinoSwitch(
                    value: device.stt,
                    onChanged: (bool value) {
                      setState(() {
                        device.stt = value;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
