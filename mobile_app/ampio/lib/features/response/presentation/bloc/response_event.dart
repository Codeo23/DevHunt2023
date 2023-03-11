part of 'response_bloc.dart';

abstract class ResponseEvent extends Equatable {
  const ResponseEvent();

  @override
  List<Object> get props => [];
}

class ResponseGetsEvent extends ResponseEvent {
  const ResponseGetsEvent({required this.postId});
  final String postId;
}

class ResponseAddEvent extends ResponseEvent {
  final String content;
  final String postId;
  final String? filePath;

  const ResponseAddEvent({
    required this.content,
    required this.postId,
    this.filePath,
  });

  @override
  List<Object> get props => [content];
}
