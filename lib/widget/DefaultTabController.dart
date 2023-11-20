import 'dart:math';
import 'dart:ui';

import 'package:doan/Screen/home_screen.dart';
import 'package:doan/models/device.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/room.dart';

class defaultTabController extends StatefulWidget {
  defaultTabController(
      {super.key,
      required this.lst_room,
      required this.lst_device,
      required this.roomIsEmpty,
      required this.callback});
  final List<Room> lst_room;
  final List<Device> lst_device;
  final bool roomIsEmpty;
  VoidCallback callback;
  @override
  State<defaultTabController> createState() => _defaultTabControllerState();
}

const List<String> list = <String>[
  'Quạt',
  'Đèn',
];

Device addThem(int? idroom) {
  Device them = Device(
      id: 0,
      stt: false,
      name: 'Thêm',
      img: 'asset/daucong.png',
      id_room: idroom);
  return them;
}

List<Device> addListDevice(int id_room) {
  List<Device> lst = [];
  lst.add(addThem(id_room));
  return lst;
}

bool sttRoom = true;
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
  void stt() {
    setState(() {
      sttRoom = roomIsEmpty;
    });
  }

  void addDevice(int? id_room) {
    setState(() {
      for (var item in widget.lst_room) {
        if (item.id == id_room) {
          Device dv = Device(
              id: item.lstDevice.length,
              stt: false,
              name: val,
              img: val == "Đèn" ? 'asset/light.png' : 'asset/fan.png',
              id_room: item.id);
          item.lstDevice.add(dv);
        }
      }
    });
  }

  void loadRoom() {
    if (widget.lst_room.isNotEmpty) {
      for (var item in widget.lst_room) {
        if (item.lstDevice.length > 1) {
          item.lstDevice.removeAt(getIndex0(item.lstDevice));
          item.lstDevice.add(addThem(item.lstDevice[0].id_room));
        } else {
          item.lstDevice = addListDevice(item.id);
        }
      }
      roomIsEmpty = false;
    } else {
      roomIsEmpty = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 2;
    var height = MediaQuery.of(context).size.height;
    TextEditingController txt_RoomName = TextEditingController();
    stt();
    print('số phòng bên defau ${widget.lst_room.length}');
    loadRoom();

    return sttRoom
        ? SizedBox(
            width: MediaQuery.of(context).size.width / 2.7,
            height: MediaQuery.of(context).size.height / 6,
            // child: MaterialButton(
            //   height: 40,
            //   onPressed: () => showDialog<String>(
            //     context: context,
            //     builder: (BuildContext context) => AlertDialog(
            //       title: const Text('Thêm phòng'),
            //       content: TextField(
            //         controller: txt_RoomName,
            //         decoration: const InputDecoration(
            //           labelText: "Nhập tên phòng",
            //         ),
            //       ),
            //       actions: <Widget>[
            //         TextButton(
            //           onPressed: () {
            //             setState(() {
            //               if (txt_RoomName.text.isNotEmpty) {
            //                 widget.lst_room.add(Room(
            //                     id: widget.lst_room.length,
            //                     lstDevice:
            //                         addListDevice(widget.lst_room.length),
            //                     name: txt_RoomName.text));
            //               }
            //               print("dèaaa${widget.lst_room.length}");
            //             });
            //           },
            //           child: const Text('Thêm'),
            //         ),
            //       ],
            //     ),
            //   ),
            //   color: Colors.blue,
            //   child: const Text('Thêm phòng'),
            // ),
          )
        : DefaultTabController(
            length: widget.lst_room.length,
            child: Column(children: [
              TabBar(
                tabs: widget.lst_room.map((e) => Text(e.name)).toList(),
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
                child: TabBarView(
                    children: widget.lst_room.map((e) => room(e)).toList()),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              fontSize: 15, fontWeight: FontWeight.bold),
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
                              onPressed: () {
                                print(widget.lst_device.length);
                                addDevice(device.id_room);
                              },
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
