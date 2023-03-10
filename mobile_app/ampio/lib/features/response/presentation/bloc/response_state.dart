part of 'response_bloc.dart';

class ResponseState {
  final LoadingStatus status;
  final List<ResponseEntity> responses;

  const ResponseState({
    this.status = LoadingStatus.initial,
    this.responses = const [],
  });

  ResponseState copyWith({
    LoadingStatus? status,
    List<ResponseEntity>? responses,
  }) {
    return ResponseState(
      status: status ?? this.status,
      responses: responses ?? this.responses,
    );
  }
}
