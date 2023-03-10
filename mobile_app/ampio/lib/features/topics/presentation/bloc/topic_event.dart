part of 'topic_bloc.dart';

abstract class TopicEvent extends Equatable {
  const TopicEvent();

  @override
  List<Object> get props => [];
}

class TopicGetsEvent extends TopicEvent {
  const TopicGetsEvent();
}