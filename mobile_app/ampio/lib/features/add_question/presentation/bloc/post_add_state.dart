import '../../../../core/utils/Enums/loading_status.dart';

class PostAddState {
  final LoadingStatus status;

  const PostAddState({
    this.status = LoadingStatus.initial,
  });

  PostAddState copyWith({
    LoadingStatus? status,
  }) {
    return PostAddState(
      status: status ?? this.status,
    );
  }
}