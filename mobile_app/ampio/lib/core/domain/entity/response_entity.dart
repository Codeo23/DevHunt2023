import 'package:ampio/core/domain/entity/topic_entity.dart';
import 'package:ampio/core/domain/entity/user_entity.dart';

class ResponseEntity {
  final int? id;
  final String content;
  final String? filePath;
  final UserEntity user;
  final String? createdAt;
  final int? reaction;

  ResponseEntity({
    this.id,
    required this.content,
    required this.user,
    this.filePath,
    this.reaction,
    required this.createdAt,
  });

  ResponseEntity.fromJson(Map<String, dynamic> json)
      : content = json['content'] as String,
        filePath = json['file'] as String,
        reaction = json['reaction'] as int,
        id = json['ID'],
        user = UserEntity.fromJson(json['author'] as Map<String, dynamic>),
        createdAt = json['CreatedAt'] as String;

  Map<String, dynamic> toJson() => {'content': content, 'file': filePath};
}
