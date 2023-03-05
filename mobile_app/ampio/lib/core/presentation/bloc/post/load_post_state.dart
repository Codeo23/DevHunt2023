part of 'post_bloc.dart';

class LoadPostState {
  final List<PostEntity>? posts;
  final LoadingStatus status;

  const LoadPostState({
    this.posts,
    this.status = LoadingStatus.initial,
  });

  LoadPostState copyWith({
    List<PostEntity>? posts,
    LoadingStatus? status,
  }) {
    return LoadPostState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
    );
  }
}