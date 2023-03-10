part of 'response_bloc.dart';

abstract class ResponseEvent extends Equatable {
  const ResponseEvent();

  @override
  List<Object> get props => [];
}

class ResponseGetsEvent extends ResponseEvent {
  const ResponseGetsEvent({required this.post_id});
  final int post_id;
}

class ResponseAddEvent extends ResponseEvent {
  final String content;
  final String? filePath;

  const ResponseAddEvent({
    required this.content,
    this.filePath,
  });

  @override
  List<Object> get props => [content];
}
