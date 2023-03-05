import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../features/login/presentation/bloc/authenticate_with_form_event.dart';
import '../../../domain/entity/user_entity.dart';
import '../../../domain/usecase/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class UserBloc extends Bloc<AuthEvent, AuthState> {

  final AuthUseCase authUseCase;

  UserBloc(
    this.authUseCase,
  ) : super(const AuthState.unknown());

  void _mapAuthenticateWithFormEventToState(
      AuthenticateWithFormEvent event, Emitter<AuthState> emit) async {

    try {
      await authUseCase.loginViaForm(event.identity, event.password);
      emit(AuthState.authenticated(UserEntity(
        matriculate: '2315',
        username: 'test',
        email: 'test@gmail.com',
      )));
    } on Exception catch (e) {
      print(e);
      emit(const AuthState.unauthenticated());
    }

  }
}