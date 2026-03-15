class AppUser {
  const AppUser({
    required this.id,
    required this.phone,
    required this.password,
  });

  final int? id;
  final String phone;
  final String password;

  Map<String, Object?> toMap() {
    return {'id': id, 'phone': phone, 'password': password};
  }

  factory AppUser.fromMap(Map<String, Object?> map) {
    return AppUser(
      id: map['id'] as int?,
      phone: map['phone'] as String,
      password: map['password'] as String,
    );
  }
}
