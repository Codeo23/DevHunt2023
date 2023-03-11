import 'package:ampio/core/domain/data/remote/repository/topic_repository.dart';
import 'package:ampio/core/domain/entity/topic_entity.dart';
import 'package:ampio/core/domain/usecase/topic_usecase.dart';
import 'package:ampio/core/utils/Enums/loading_status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'topic_event.dart';
part 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent,TopicState> {
  final TopicRepository topicRepository;
  final TopicUseCase topicUseCase = TopicUseCase();

  TopicBloc(this.topicRepository) : super(const TopicState()) {
    on<TopicGetsEvent>(_topicGets);
  }

  void _topicGets(
      TopicGetsEvent event,
      Emitter<TopicState> emit,
      ) async {
    try {
      emit(state.copyWith(status: LoadingStatus.loading));
      final topics = await topicUseCase.convertTopicsDataToTopicEntity();
      emit(
        state.copyWith(status: LoadingStatus.success,topics: topics),
      );
    } catch (e) {
      print('Error $e');
      emit(
        state.copyWith(status: LoadingStatus.error),
      );
    }
  }
}