import 'package:doan/widget/DefaultTabController.dart';
import 'package:doan/widget/bottomnaviga.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/device.dart';
import '../models/room.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

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
List<Device> lstDevice = [
  // Device(id: 1, stt: false, name: 'Đèn', img: 'asset/light.png', id_room: 1),
  // Device(id: 2, stt: false, name: 'Đèn', img: 'asset/light.png', id_room: 1),
  // Device(id: 3, stt: false, name: 'Đèn', img: 'asset/light.png', id_room: 1),
  // Device(id: 0, stt: false, name: 'Thêm', img: 'asset/daucong.png', id_room: 1),
  // Device(id: 1, stt: false, name: 'Quạt', img: 'asset/fan.png', id_room: 2),
  // Device(id: 2, stt: false, name: 'Quạt', img: 'asset/fan.png', id_room: 2),
  // Device(id: 0, stt: false, name: 'Thêm', img: 'asset/daucong.png', id_room: 2),
  // Device(id: 1, stt: true, name: 'Đèn', img: 'asset/light.png', id_room: 3),
  // Device(id: 2, stt: true, name: 'Đèn', img: 'asset/light.png', id_room: 3),
  // Device(id: 0, stt: false, name: 'Thêm', img: 'asset/daucong.png', id_room: 3),
  // Device(id: 1, stt: true, name: 'Quạt', img: 'asset/fan.png', id_room: 4),
  // Device(id: 2, stt: true, name: 'Quạt', img: 'asset/fan.png', id_room: 4),
  // Device(id: 0, stt: false, name: 'Thêm', img: 'asset/daucong.png', id_room: 4),
];

List<Room> lstRoom = [
  // Room(id: 1, lstDevice: lst_device_livingroom, name: 'Phòng khách'),
  // Room(id: 2, lstDevice: lst_device_kitchen, name: 'Phòng bếp'),
  // Room(id: 3, lstDevice: lst_device_bedroom, name: 'Phòng ngủ'),
  // Room(id: 4, lstDevice: lst_device_bathroom, name: 'Phòng tắm'),
];
// lst_device_livingroom =
//     lst_device.where((element) => element.id_room == 1).toList();
// lst_device_livingroom.removeAt(getIndex0(lst_device_livingroom));
// lst_device_livingroom.add(addThem(lst_device_livingroom[0].id_room));
// lst_device_kitchen =
//     lst_device.where((element) => element.id_room == 2).toList();
// lst_device_kitchen.removeAt(getIndex0(lst_device_kitchen));
// lst_device_kitchen.add(addThem(lst_device_kitchen[0].id_room));
// lst_device_bedroom =
//     lst_device.where((element) => element.id_room == 3).toList();
// lst_device_bedroom.removeAt(getIndex0(lst_device_bedroom));
// lst_device_bedroom.add(addThem(lst_device_bedroom[0].id_room));

// lst_device_bathroom =
//     lst_device.where((element) => element.id_room == 4).toList();
// lst_device_bathroom.removeAt(getIndex0(lst_device_bathroom));
// lst_device_bathroom.add(addThem(lst_device_bathroom[0].id_room));
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

void loadRoom() {
  if (lstRoom.isNotEmpty) {
    for (var item in lstRoom) {
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

  void addRoom(Room room) {
    setState(() {
      // var list_device = [];
      // room.lstDevice.forEach((device) {
      //   var _device = {
      //     "id": device.id,
      //     "stt":device.stt,
      //     "name":device.name
      //   };
      // });

      lstRoom.add(room);
      //lstDevice.add(room.lstDevice[0]);
    });
  }

  void printCount() {
    print("build $count");
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    loadRoom();

    count++;
    printCount();
    print("số phòng bên home ${lstRoom.length}");

    Device addThem(int? idroom) {
      Device them = Device(
          id: 0,
          stt: false,
          name: 'Thêm',
          img: 'asset/daucong.png',
          id_room: idroom);
      return them;
    }

    List<Device> addListDevice(int idRoom) {
      List<Device> lst = [];
      lst.add(addThem(idRoom));
      return lst;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Trang chủ'),
          backgroundColor: Colors.blue,
        ),
        bottomNavigationBar: const BottomNav(
          idx: 0,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            defaultTabController(
              lst_device: lstDevice,
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
                          onPressed: () {},
                          color: Colors.red,
                          child: const Text('Báo cháy'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.7,
                        child: MaterialButton(
                          height: 40,
                          onPressed: () {
                            setState(() {
                              lstRoom.forEach((room) {
                                room.lstDevice.forEach((device) {
                                  if (device.name == 'Đèn') {
                                    device.stt = false;
                                  }
                                });
                              });
                            });
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
                            builder: (BuildContext context) => AlertDialog(
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
                                          id: lstRoom.length,
                                          lstDevice:
                                              addListDevice(lstRoom.length),
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
                    ],
                  ),
                ),
                Container(
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
                      child: const SingleChildScrollView(
                        child: Column(
                          children: [
                            Text('Thông báo'),
                            Text('Thông báo'),
                            Text('Thông báo'),
                            Text('Thông báo'),
                            Text('Thông báo'),
                            Text('Thông báo'),
                            Text('Thông báo'),
                            Text('Thông báo'),
                            Text('Thông báo'),
                            Text('Thông báo'),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ],
            )
          ]),
        ));
  }
}
