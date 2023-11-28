import 'package:doan/Screen/home_screen.dart';
import 'package:doan/models/device.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/room.dart';

class defaultTabController extends StatefulWidget {
  defaultTabController(
      {super.key,
      required this.lst_room,
      required this.roomIsEmpty,
      required this.callback});
  final List<Room> lst_room;
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
      id_room: idroom,
      delete: false);
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

  Future<void> addDevice(int? id_room) async {
    int i;
    bool flag = false;
    final response = await FirebaseDatabase.instance.ref().child("room").get();
    for (DataSnapshot room in response.children) {
      if (int.parse(room.child("id").value.toString()) == id_room) {
        var lst_device = [];
        for (i = 0; i < room.child("lstDevice").children.length; i++) {
          var dv1 = {
            "id": int.parse(room
                .child("lstDevice")
                .child("$i")
                .child("id")
                .value
                .toString()),
            "stt": bool.parse(room
                .child("lstDevice")
                .child("$i")
                .child("stt")
                .value
                .toString()),
            "name": room
                .child("lstDevice")
                .child("$i")
                .child("name")
                .value
                .toString(),
            "img": room
                .child("lstDevice")
                .child("$i")
                .child("img")
                .value
                .toString(),
            "id_room": int.parse(room
                .child("lstDevice")
                .child("$i")
                .child("id_room")
                .value
                .toString()),
            "delete": bool.parse(room
                .child("lstDevice")
                .child("$i")
                .child("delete")
                .value
                .toString())
          };
          lst_device.add(dv1);
        }
        lst_device.forEach((device) {
          if (device["delete"] == true) {
            if (device["name"] == val) {
              if (!flag) {
                device["delete"] = false.toString();
                flag = true;
              }
            }
          }
        });
        if (!flag) {
          var dv = {
            "id": room.child("lstDevice").children.length,
            "stt": false,
            "name": val,
            "img": val == "Đèn" ? 'asset/light.png' : 'asset/fan.png',
            "id_room": int.parse(room.child("id").value.toString()),
            "delete": false
          };
          setState(() {
            lst_device.add(dv);
          });
        }
        var ref =
            await FirebaseDatabase.instance.ref().child("room/${id_room}");
        ref.child("lstDevice").set(lst_device).then((lstdevice) {
          print('Thêm thiết bị thành công');
          flag = false;
        }).catchError((onError) {
          print('Thêm thiết bị không thành công');
          flag = false;
        });
      }
    }
  }

  void loadRoom() {
    if (widget.lst_room.isNotEmpty) {
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
    loadRoom();
    return roomIsEmpty
        ? SizedBox(
            width: MediaQuery.of(context).size.width / 2.7,
            height: MediaQuery.of(context).size.height / 6,
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
    bool _va = device.stt;
    return device.id != 0
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: 180,
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white38),
            child: Stack(
              children: [
                TextButton(
                  onPressed: () {
                    var ref = FirebaseDatabase.instance
                        .ref()
                        .child("room/${device.id_room}/lstDevice");
                    ref
                        .child("${device.id}")
                        .update({"stt": !_va}).then((value) {
                      print("Dổi trạng thái nút thành công1");
                    }).catchError((onError) {
                      print("Dổi trạng thái nút không thành công thành côn1");
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
                            color: device.stt
                                ? Colors.white70
                                : Colors.transparent,
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
                              var ref = FirebaseDatabase.instance
                                  .ref()
                                  .child("room/${device.id_room}");
                              ref
                                  .child("lstDevice/${device.id}")
                                  .update({"stt": value}).then((value) {
                                print("Dổi trạng thái nút thành công");
                              }).catchError((onError) {
                                print(
                                    "Dổi trạng thái nút không thành công thành công");
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          var delete = FirebaseDatabase.instance
                              .ref()
                              .child(
                                  'room/${device.id_room}/lstDevice/${device.id}')
                              .update({"delete": true}).then((value) {
                            print("Xóa thành công");
                          }).catchError((onError) {
                            print('Xóa không thành công');
                          });
                        },
                        icon: const Icon(Icons.close)),
                  ],
                ),
              ],
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
