import 'package:ampio/core/domain/data/remote/repository/topic_repository.dart';
import 'package:ampio/core/domain/entity/topic_entity.dart';

class TopicUseCase {

  final TopicRepository topicRepository = TopicRepository();

  Future<List<TopicEntity>> convertTopicsDataToTopicEntity() async {

    final topics = await topicRepository.getTopics() as List<dynamic>;
    List<TopicEntity> allTopics = [];

    for (var e in topics) {
      allTopics.add(TopicEntity.fromJson(e));
    }

    return allTopics;
  }
}