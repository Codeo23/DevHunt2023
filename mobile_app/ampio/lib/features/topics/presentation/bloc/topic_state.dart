part of 'topic_bloc.dart';

class TopicState {
  final LoadingStatus status;
  final List<TopicEntity> topics;

  const TopicState({
    this.status = LoadingStatus.initial,
    this.topics = const [],
});

  TopicState copyWith({
    LoadingStatus? status,
    List<TopicEntity>? topics,
}) {
    return TopicState(
      status:  status ?? this.status,
      topics: topics ?? this.topics,
    );
  }
}