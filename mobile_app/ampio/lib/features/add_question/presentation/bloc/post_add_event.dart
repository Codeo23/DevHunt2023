import '../../../../core/presentation/bloc/post/post_bloc.dart';

class PostAddEvent extends LoadPostEvent {
  final String topic;
  final String question;
  final String description;

  PostAddEvent({
    required this.topic,
    required this.question,
    required this.description
  });

  @override
  List<Object> get props => [topic, question, description];
}