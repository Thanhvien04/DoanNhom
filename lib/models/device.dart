class Device {
  int id;
  bool stt;
  String name;
  String img;
  int? id_room;
  bool delete;
  Device(
      {required this.id,
      required this.stt,
      required this.name,
      required this.img,
      required this.id_room,
      required this.delete});
}
