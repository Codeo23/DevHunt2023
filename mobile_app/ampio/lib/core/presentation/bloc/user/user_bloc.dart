import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../features/login/presentation/bloc/authenticate_with_form_event.dart';
import '../../../domain/data/remote/repository/auth_repository.dart';
import '../../../domain/entity/user_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class UserBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository authRepository;

  UserBloc(
    this.authRepository,
  ) : super(const AuthState.unknown()){
    on<AuthenticateWithFormEvent>(_mapAuthenticateWithFormEventToState);
  }

  void _mapAuthenticateWithFormEventToState(
      AuthenticateWithFormEvent event, Emitter<AuthState> emit) async {

    try {
      await authRepository.login(event.identity, event.password);
      emit(AuthState.authenticated(UserEntity(
        matriculate: '2315',
        username: 'test',
        email: 'test@gmail.com',
      )));
    } on Exception catch (e) {
      print(e);
      emit(const AuthState.unauthenticated());
      emit(const AuthState.unknown());
    }

  }
}