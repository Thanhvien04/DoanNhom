class UserProfile {
  String phoneNumber;
  String username;
  String email;

  UserProfile({
    required this.phoneNumber,
    required this.username,
    required this.email,
  });

  // Hàm chuyển đổi thành Map để lưu vào Firebase Realtime Database.

  static Map<String, dynamic> toMap(UserProfile userProfile) {
    return {
      // 'displayName': userProfile.displayName,
      'phoneNumber': userProfile.phoneNumber,
      'username': userProfile.username,
      'email': userProfile.email,
    };
  }

  // Hàm tạo từ Map để đọc từ Firebase Realtime Database.
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      phoneNumber: map['phoneNumber'] ?? '',
      username: map['username'],
      email: map['email'] ?? '',
    );
  }
}
