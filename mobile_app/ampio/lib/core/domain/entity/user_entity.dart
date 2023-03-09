class UserEntity {
  final int matriculate;
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
      : matriculate = json['matricule'] as int,
        username = json['username'] as String,
        password = json['password'] ?? '',
        email = json['email'] ?? '',
        avatar = json['avatar'] ?? '';
}