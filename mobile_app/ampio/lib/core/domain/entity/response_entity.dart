class ResponseEntity {
  final String content;
  final String? filePath;
  final int? reaction;

  ResponseEntity({
    required this.content,
    this.filePath,
    this.reaction,
  });

  ResponseEntity.fromJson(Map<String, dynamic> json)
      : content = json['content'] as String,
        filePath = json['file'] as String,
        reaction = json['reaction'] as int;

  Map<String, dynamic> toJson() => {'content': content, 'file': filePath};
}
