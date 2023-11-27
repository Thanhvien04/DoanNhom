class Sesion {
  static final Sesion _session = Sesion._internal();
  String? _userid;
  factory Sesion() {
    return _session;
  }
  Sesion._internal() {}
  String? get userId => _userid;

  set userName(userName) {}

  set userId(String? value) {
    _userid = value?.toString() ?? "";
    // Thực hiện các logic cần thiết khi giá trị userId thay đổi
  }
}
