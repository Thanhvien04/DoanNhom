import 'package:doan/widget/DefaultTabController.dart';
import 'package:doan/widget/bottomnaviga.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/device.dart';
import '../models/room.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

//DatabaseReference ref = FirebaseDatabase.instance.ref();
bool _isExpanded = true;
hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}

bool roomIsEmpty = true;
TextEditingController txt_RoomName = TextEditingController();
List<Room> lstRoom = [];
List<Room> lstRoomFull = [];
int getIndex0(List<Device> lst) {
  int index = 0;
  Device dv;
  for (var item in lst) {
    if (item.id == 0) {
      index = lst.indexOf(item);
    }
  }
  return index;
}

List<Device> addListDevice(int idRoom) {
  List<Device> lst = [];
  lst.add(addThem(idRoom));
  return lst;
}

// ignore: camel_case_types
class _Home_ScreenState extends State<Home_Screen> {
  double _currentSliderValue = 20;
  // ignore: non_constant_identifier_names
  TextEditingController txt_RoomName = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    loadRoom();
  }

  Future<void> turnOffAllLights() async {
    lstRoom.forEach((room) {
      room.lstDevice.forEach((device) {
        if (device.name == "Đèn") {
          device.stt = false;
        }
      });
    });
    upLoadRoom();
  }

  Future<void> upLoadRoom() async {
    lstRoom.forEach((room) async {
      var lst_device = [];
      room.lstDevice.forEach(
        (device) {
          var dv = {
            "id": device.id,
            "stt": device.stt,
            "name": device.name,
            "img": device.img,
            "id_room": device.id_room,
            "delete": device.delete
          };
          lst_device.add(dv);
        },
      );
      var ref = await FirebaseDatabase.instance.ref().child("room/${room.id}");
      ref.child("lstDevice").set(lst_device).then((lstdevice) {
        print('Upload phòng ${room.name} thành công');
      }).catchError((onError) {
        print('Upload phòng ${room.name} không thành công');
      });
    });
  }

  bool baoChay = false;

  Future<void> loadRoom() async {
    int i;
    bool flag = false;
    List<Room> lst_room = [];
    List<Room> lst_room1 = [];
    final response = await FirebaseDatabase.instance.ref().child("room").get();
    for (DataSnapshot room in response.children) {
      if (room.key != "firealarm") {
        List<Device> lst_device = [];
        if (room.child("delete").value.toString() == false.toString()) {
          flag = true;
          for (i = 0; i < room.child("lstDevice").children.length; i++) {
            if (room
                    .child("lstDevice")
                    .child("$i")
                    .child("delete")
                    .value
                    .toString() ==
                false.toString()) {
              Device dv = Device(
                  id: int.parse(room
                      .child("lstDevice")
                      .child("$i")
                      .child("id")
                      .value
                      .toString()),
                  stt: bool.parse(room
                      .child("lstDevice")
                      .child("$i")
                      .child("stt")
                      .value
                      .toString()),
                  name: room
                      .child("lstDevice")
                      .child("$i")
                      .child("name")
                      .value
                      .toString(),
                  img: room
                      .child("lstDevice")
                      .child("$i")
                      .child("img")
                      .value
                      .toString(),
                  id_room: int.parse(room
                      .child("lstDevice")
                      .child("$i")
                      .child("id_room")
                      .value
                      .toString()),
                  delete: bool.parse(room
                      .child("lstDevice")
                      .child("$i")
                      .child("delete")
                      .value
                      .toString()));

              lst_device.add(dv);
            }
          }
          Room roomnew = Room(
              id: int.parse(room.child('id').value.toString()),
              lstDevice: lst_device,
              delete: false,
              name: room.child('name').value.toString());
          lst_room.add(roomnew);
          lst_room1.add(roomnew);
          setState(() {
            lstRoom = lst_room;
            lstRoomFull = lst_room1;
          });
          if (lstRoom.isNotEmpty) {
            roomIsEmpty = false;
          } else {
            roomIsEmpty = true;
          }
        }
        if (room.child("delete").value.toString() == true.toString()) {
          for (i = 0; i < room.child("lstDevice").children.length; i++) {
            if (room
                    .child("lstDevice")
                    .child("$i")
                    .child("delete")
                    .value
                    .toString() ==
                false.toString()) {
              Device dv = Device(
                  id: int.parse(room
                      .child("lstDevice")
                      .child("$i")
                      .child("id")
                      .value
                      .toString()),
                  stt: bool.parse(room
                      .child("lstDevice")
                      .child("$i")
                      .child("stt")
                      .value
                      .toString()),
                  name: room
                      .child("lstDevice")
                      .child("$i")
                      .child("name")
                      .value
                      .toString(),
                  img: room
                      .child("lstDevice")
                      .child("$i")
                      .child("img")
                      .value
                      .toString(),
                  id_room: int.parse(room
                      .child("lstDevice")
                      .child("$i")
                      .child("id_room")
                      .value
                      .toString()),
                  delete: bool.parse(room
                      .child("lstDevice")
                      .child("$i")
                      .child("delete")
                      .value
                      .toString()));

              lst_device.add(dv);
            }
          }
          Room roomnew = Room(
              id: int.parse(room.child('id').value.toString()),
              lstDevice: lst_device,
              delete: false,
              name: room.child('name').value.toString());
          lst_room1.add(roomnew);
          setState(() {
            lstRoomFull = lst_room1;
          });
        }
      } else {
        baoChay = bool.parse(room.value.toString());
        print(baoChay);
      }
      if (flag == false) {
        setState(() {
          lstRoom = [];
        });
      }
    }
  }

  Future<void> addRoom(Room room) async {
    var list_device = [];
    room.lstDevice.forEach((device) {
      var _device = {
        "id": device.id.toString(),
        "stt": device.stt.toString(),
        "name": device.name,
        "img": device.img,
        "id_room": device.id_room.toString(),
        "delete": false.toString()
      };
      list_device.add(_device);
    });
    var _room = {
      "name": room.name,
      "lstDevice": list_device,
      "id": room.id,
      "delete": room.delete
    };
    bool flag = false;
    final response = await FirebaseDatabase.instance.ref().child("room").get();
    for (DataSnapshot _room in response.children) {
      if (_room.child("delete").value.toString() == true.toString()) {
        if (_room.child("name").value.toString().toLowerCase() ==
            room.name.toLowerCase()) {
          flag = true;
          final ref1 = FirebaseDatabase.instance.ref().child("room");
          ref1
              .child(_room.child("id").value.toString())
              .update({"delete": false}).then((value) {
            print("Thêm phòng thành công");
          }).catchError((onError) {
            print('Thêm phòng không thành công');
          });
          final ref2 = FirebaseDatabase.instance.ref().child("room");
          ref2
              .child(_room.child("id").value.toString())
              .child("lstDevice")
              .set(list_device)
              .then((value) {
            print("Sửa lại thiết bị thành công");
          }).catchError((onError) {
            print('Sửa lại thiết bị không thành công');
          });
        }
      }
    }
    if (flag == false) {
      var ref = FirebaseDatabase.instance.ref().child("room");
      ref.child(room.id.toString()).set(_room).then((room) {
        print('Thêm thành công');
      }).catchError((onError) {
        print('Thêm không thành công');
      });
      ref.child("firealarm").set(false).then((value) {
        print('Thêm báo cháy thành công');
      }).catchError((onError) {
        print('Thêm báo cháy không thành công');
      });
    }
  }

  int getIDRoom(String name) {
    int index = lstRoomFull.length;
    lstRoomFull.forEach((room) {
      if (room.name == txt_RoomName.text) {
        index = room.id;
      }
    });
    return index;
  }

  @override
  Widget build(BuildContext context) {
    loadRoom();
    return SafeArea(
        child: !baoChay
            ? Scaffold(
                appBar: AppBar(
                    title: const Text('Trang chủ'),
                    backgroundColor: Colors.blue,
                    automaticallyImplyLeading: false),
                bottomNavigationBar: const BottomNav(
                  idx: 0,
                ),
                body: SingleChildScrollView(
                  child: Column(children: [
                    defaultTabController(
                      lst_room: lstRoom,
                      roomIsEmpty: roomIsEmpty,
                      callback: () {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.7,
                                child: MaterialButton(
                                  height: 40,
                                  onPressed: () {
                                    var ref = FirebaseDatabase.instance
                                        .ref()
                                        .child("room");
                                    ref
                                        .child("firealarm")
                                        .set(!baoChay)
                                        .then((value) {
                                      print('Báo cháy thành công');
                                    }).catchError((onError) {
                                      print('Báo cháy không thành công');
                                    });
                                  },
                                  color: Colors.red,
                                  child: const Text('Báo cháy'),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.7,
                                child: MaterialButton(
                                  height: 40,
                                  onPressed: () {
                                    turnOffAllLights();
                                  },
                                  color: Colors.blue,
                                  child: const Text('Tắt hết đèn'),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.7,
                                child: MaterialButton(
                                  height: 40,
                                  onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Thêm phòng'),
                                      content: TextField(
                                        controller: txt_RoomName,
                                        decoration: const InputDecoration(
                                          labelText: "Nhập tên phòng",
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            if (txt_RoomName.text.isNotEmpty) {
                                              addRoom(Room(
                                                  delete: false,
                                                  id: lstRoom.length,
                                                  lstDevice: addListDevice(
                                                      getIDRoom(
                                                          txt_RoomName.text)),
                                                  name: txt_RoomName.text));
                                              roomIsEmpty = false;
                                            }
                                          },
                                          child: const Text('Thêm'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  color: Colors.blue,
                                  child: const Text('Thêm phòng'),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.7,
                                child: MaterialButton(
                                  height: 40,
                                  onPressed: () {
                                    lstRoom.length != 0
                                        ? showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text('Xóa phòng'),
                                              content: SizedBox(
                                                height: 100,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: lstRoom
                                                        .map((room) =>
                                                            lstRoomDel(room))
                                                        .toList(),
                                                  ),
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          )
                                        : showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text('Xóa phòng'),
                                              content: const SizedBox(
                                                height: 100,
                                                child: Text(
                                                    'Không có phòng để xóa'),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                  },
                                  color: Colors.blue,
                                  child: const Text('Xóa phòng'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: Column(children: [
                            const Text('Tốc độ quạt'),
                            Slider(
                              value: _currentSliderValue,
                              max: 100,
                              divisions: 100,
                              label: _currentSliderValue.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _currentSliderValue = value;
                                });
                              },
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 100,
                              color: Colors.black12,
                              child: SingleChildScrollView(
                                child: Column(
                                    children: lstRoom
                                        .map((room) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: room.lstDevice
                                                .map((device) => Text(
                                                      device.id != 0
                                                          ? '${device.name} ${room.name.toLowerCase()} ${device.stt ? ': ON' : ': OFF'}'
                                                          : '',
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ))
                                                .toList()))
                                        .toList()),
                              ),
                            )
                          ]),
                        ),
                      ],
                    )
                  ]),
                ))
            : Scaffold(
                backgroundColor: Colors.red,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Nhà bạn đang cháy"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.7,
                        child: MaterialButton(
                          height: 40,
                          onPressed: () {
                            var ref =
                                FirebaseDatabase.instance.ref().child("room");
                            ref.child("firealarm").set(!baoChay).then((value) {
                              print('Báo cháy thành công');
                            }).catchError((onError) {
                              print('Báo cháy không thành công');
                            });
                          },
                          color: Colors.white,
                          child: const Text('Tắt báo cháy'),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  Row lstRoomDel(Room room) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(room.name),
        IconButton(
            onPressed: () {
              var delete = FirebaseDatabase.instance
                  .ref()
                  .child('room/${room.id}')
                  .update({"delete": true}).then((value) {
                print("Xóa phòng thành công");
              }).catchError((onError) {
                print('Xóa phòng không thành công');
              });
            },
            icon: const Icon(Icons.close)),
      ],
    );
  }
}
