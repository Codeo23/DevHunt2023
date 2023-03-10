class CommentEntity {
  final String content;
  final String? filePath;
  final int? reaction;

  CommentEntity({
    required this.content,
    this.filePath,
    this.reaction,
  });

  CommentEntity.fromJson(Map<String, dynamic> json)
      : content = json['content'] as String,
        filePath = json['file'] as String,
        reaction = json['reaction'] as int;

  Map<String, dynamic> toJson() => {'content': content, 'file': filePath};
}
