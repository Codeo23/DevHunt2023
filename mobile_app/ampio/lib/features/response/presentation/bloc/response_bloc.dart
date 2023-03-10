import 'package:ampio/core/domain/entity/response_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/Enums/loading_status.dart';
import '../../../../core/domain/data/remote/repository/response_repository.dart';

part 'response_event.dart';
part 'response_state.dart';

class ResponseBloc extends Bloc<ResponseEvent, ResponseState> {
  final ResponseRepository responseRepository;

  ResponseBloc(this.responseRepository) : super(const ResponseState()) {
    on<ResponseGetsEvent>(_responseGets);
    on<ResponseAddEvent>(_responseAdd);
  }

  void _responseGets(
    ResponseGetsEvent event,
    Emitter<ResponseState> emit,
  ) async {
    try {
      emit(
        state.copyWith(status: LoadingStatus.loading),
      );
      final data =
          await responseRepository.getAllComments(post_id: event.post_id);
      print(data);
      emit(
        state.copyWith(status: LoadingStatus.success),
      );
    } catch (e) {
      print("Error $e");
      emit(
        state.copyWith(status: LoadingStatus.error),
      );
    }
  }

  void _responseAdd(ResponseAddEvent event, Emitter<ResponseState> emit) async {
    try {
      emit(
        state.copyWith(status: LoadingStatus.loading),
      );
      final data = await responseRepository.addComment(
          content: event.content, filePath: event.filePath);
      print(data);
      emit(
        state.copyWith(status: LoadingStatus.success,responses: data),
      );
    } catch (_) {
      emit(state.copyWith(status: LoadingStatus.error));
    }
  }
}
