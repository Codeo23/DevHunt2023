part of 'response_add_bloc.dart';

class ResponseAddState {
  final LoadingStatus status;

  const ResponseAddState({
    this.status = LoadingStatus.initial,
  });

  ResponseAddState copyWith({
    LoadingStatus? status,
  }) {
    return ResponseAddState(
      status: status ?? this.status,
    );
  }
}
