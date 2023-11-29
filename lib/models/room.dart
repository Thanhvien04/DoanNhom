import 'package:doan/models/device.dart';

class Room {
  final String name;
  List<Device> lstDevice;
  final int id;
  Room({required this.id, required this.lstDevice, required this.name});
}