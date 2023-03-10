part of 'response_add_bloc.dart';

class ResponseAddEvent extends Equatable {
  final String content;
  final String? filePath;

  const ResponseAddEvent({
    required this.content,
    this.filePath,
  });

  @override
  List<Object> get props => [content];
}
