import 'package:ampio/core/domain/entity/response_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/Enums/loading_status.dart';
import '../../../../core/domain/data/remote/repository/response_repository.dart';
import '../../../../core/domain/usecase/response_usecase.dart';

part 'response_event.dart';

part 'response_state.dart';

class ResponseBloc extends Bloc<ResponseEvent, ResponseState> {
  final ResponseRepository responseRepository;
  final ResponseUseCase responseUseCase = ResponseUseCase();

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
      final responses = await responseUseCase
          .convertResponseDataToResponseEntity(postId: event.postId);
      print(responses);
      emit(
        state.copyWith(status: LoadingStatus.success, responses: responses),
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
        content: event.content,
        filePath: event.filePath,
        postId: event.postId,
      );
      print(data);
      emit(
        state.copyWith(status: LoadingStatus.success),
      );
    } catch (_) {
      emit(state.copyWith(status: LoadingStatus.error));
    }
  }
}
