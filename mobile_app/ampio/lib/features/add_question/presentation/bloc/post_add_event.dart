import 'package:equatable/equatable.dart';

class PostAddEvent extends Equatable {
  final String topic;
  final String question;
  final String description;

  const PostAddEvent({
    required this.topic,
    required this.question,
    required this.description
  });

  @override
  List<Object> get props => [topic, question, description];
}