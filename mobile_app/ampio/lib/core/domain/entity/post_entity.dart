import 'user_entity.dart';

class PostEntity {
  final int? id;
  final String title;
  final String content;
  final String? file;
  final UserEntity user;
  final String? createdAt;

  PostEntity({
    this.id,
    required this.title,
    required this.content,
    this.file,
    required this.user,
    required this.createdAt,
  });

  PostEntity.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        title = json['title'] as String,
        content = json['content'] as String,
        file = json['file'] as String,
        user = UserEntity.fromJson(json['author'] as Map<String, dynamic>),
        createdAt = json['CreatedAt'] as String;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
  };
}