import 'package:bloc/bloc.dart';

import '../../../domain/data/remote/repository/post_repository.dart';
import '../load_event.dart';
import '../../../domain/entity/post_entity.dart';
import '../../../utils/Enums/loading_status.dart';

part 'load_post_event.dart';
part 'load_post_state.dart';

class PostBloc extends Bloc<LoadPostEvent, LoadPostState> {

  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(const LoadPostState()) {
    on<LoadPostEvent>((event, emit) => mapLoadPostEventToState(event, emit));
  }

  void mapLoadPostEventToState(LoadPostEvent event, Emitter<LoadPostState> emit) async {

    emit(state.copyWith(status: LoadingStatus.loading));
    try {
      final posts = await postRepository.getPosts();
      emit(state.copyWith(posts: posts, status: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadingStatus.error));
    }
  }
}