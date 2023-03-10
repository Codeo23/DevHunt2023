import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/Enums/loading_status.dart';
import '../../../../core/domain/data/remote/repository/response_repository.dart';

part 'response_add_event.dart';

part 'response_add_state.dart';

class ResponseBloc extends Bloc<ResponseAddEvent, ResponseAddState> {
  final ResponseRepository responseRepository;

  ResponseBloc(this.responseRepository) : super(const ResponseAddState()) {
    on<ResponseAddEvent>(_responseAdd);
  }

  void _responseAdd(
      ResponseAddEvent event, Emitter<ResponseAddState> emit) async {
    try {
      emit(
        state.copyWith(status: LoadingStatus.loading),
      );
      final data = await responseRepository.addComment(
          content: event.content, filePath: event.filePath);
      print(data);
      emit(
        state.copyWith(status: LoadingStatus.success),
      );
    } catch (_) {
      emit(state.copyWith(status: LoadingStatus.error));
    }
  }
}
