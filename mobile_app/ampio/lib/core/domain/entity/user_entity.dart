class UserEntity {
  final String matriculate;
  final String username;
  final String? password;
  final String? email;
  final String? avatar;

  UserEntity({
    required this.matriculate,
    required this.username,
    this.password,
    this.email,
    this.avatar,
  });

  UserEntity.fromJson(Map<String, dynamic> json)
      : matriculate = json['matriculate'],
        username = json['username'],
        password = json['password'] ?? '',
        email = json['email'] ?? '',
        avatar = json['avatar'] ?? '';
}