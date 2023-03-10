class TopicEntity {
  final String topic;
  final String image;

  TopicEntity({
    required this.image,
    required this.topic,
  });

  TopicEntity.fromJson(Map<String, dynamic> json)
      : topic = json['topic'],
        image = json['image'];
}
