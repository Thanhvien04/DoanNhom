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

const List<String> list = <String>[
  'Quạt',
  'Đèn',
];
List<Device> lst_device = [
  Device(id: 1, stt: false, name: 'Đèn', img: 'asset/light.png', id_room: 1),
  Device(id: 2, stt: false, name: 'Đèn', img: 'asset/light.png', id_room: 1),
  Device(id: 3, stt: false, name: 'Đèn', img: 'asset/light.png', id_room: 1),
  Device(id: 0, stt: false, name: 'Thêm', img: 'asset/daucong.png', id_room: 1),
  Device(id: 1, stt: false, name: 'Quạt', img: 'asset/fan.png', id_room: 2),
  Device(id: 2, stt: false, name: 'Quạt', img: 'asset/fan.png', id_room: 2),
  Device(id: 0, stt: false, name: 'Thêm', img: 'asset/daucong.png', id_room: 2),
  Device(id: 1, stt: true, name: 'Đèn', img: 'asset/light.png', id_room: 3),
  Device(id: 2, stt: true, name: 'Đèn', img: 'asset/light.png', id_room: 3),
  Device(id: 0, stt: false, name: 'Thêm', img: 'asset/daucong.png', id_room: 3),
  Device(id: 1, stt: true, name: 'Quạt', img: 'asset/fan.png', id_room: 4),
  Device(id: 2, stt: true, name: 'Quạt', img: 'asset/fan.png', id_room: 4),
  Device(id: 0, stt: false, name: 'Thêm', img: 'asset/daucong.png', id_room: 4),
];
List<Device> lst_device_bedroom = [];
List<Device> lst_device_livingroom = [];
List<Device> lst_device_bathroom = [];
List<Device> lst_device_kitchen = [];
bool stt_build_fisrt = false;
hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}

class _defaultTabControllerState extends State<defaultTabController> {
  bool switchValue = true;
  String val = list.first;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 2;
    var height = MediaQuery.of(context).size.height;

    lst_device_livingroom =
        lst_device.where((element) => element.id_room == 1).toList();
    lst_device_kitchen =
        lst_device.where((element) => element.id_room == 2).toList();
    lst_device_bedroom =
        lst_device.where((element) => element.id_room == 3).toList();
    lst_device_bathroom =
        lst_device.where((element) => element.id_room == 4).toList();
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
            height: 350,
            child: TabBarView(children: [
              room(lstRoom[0]),
              room(lstRoom[1]),
              room(lstRoom[2]),
              room(lstRoom[3]),
            ]),
          )
        ]));
  }

  GridView room(Room room) {
    return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 2.0,
        children: List.generate(room.lstDevice.length, (index) {
          return Center(
            child: device(room.lstDevice[index]),
          );
        }));
  }

  Container device(Device device) {
    return device.id != 0
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: 180,
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white38),
            child: TextButton(
              onPressed: () {
                setState(() {
                  device.stt = !device.stt;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: device.stt ? Colors.white70 : Colors.transparent,
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
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                  ),
                ],
              ),
            ))
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: 180,
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white38),
            child: TextButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext content) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            hexStringToColor("CB2B93"),
                            hexStringToColor("9546c4"),
                            hexStringToColor("5E66F6"),
                          ])),
                          child: Column(children: [
                            Row(children: [
                              const Expanded(
                                  child: Text('Thiết bị',
                                      style: TextStyle(fontSize: 30))),
                              DropdownButton<String>(
                                value: val,
                                icon: const Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                ),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 30),
                                onChanged: (String? value) {
                                  setState(() {
                                    val = value!;
                                  });
                                },
                                items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ]),
                            const SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue),
                              child: const Text(
                                'Thêm thiết bị',
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ]),
                        );
                      });
                    });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: device.stt ? Colors.white70 : Colors.transparent,
                      ),
                      child: Image.asset(
                        device.img,
                        height: 65,
                      )),
                  Text(
                    device.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ));
  }
}
