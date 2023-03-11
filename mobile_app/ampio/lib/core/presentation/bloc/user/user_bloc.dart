import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../features/login/presentation/bloc/authenticate_with_form_event.dart';
import '../../../domain/data/remote/repository/auth_repository.dart';
import '../../../domain/entity/user_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class UserBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository authRepository;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  UserBloc(
    this.authRepository,
  ) : super(const AuthState.unknown()){
    on<AuthenticateWithFormEvent>(_mapAuthenticateWithFormEventToState);
  }

  void _mapAuthenticateWithFormEventToState(
      AuthenticateWithFormEvent event, Emitter<AuthState> emit) async {

    try {
      emit(const AuthState.loading());
      final data = await authRepository.login(event.identity, event.password);
      await _secureStorage.write(key: 'token', value: data['token']);
      final user = await authRepository.getCurrentUser();
      emit(AuthState.authenticated(UserEntity.fromJson(user)));
    } on Exception catch (e) {
      print(e);
      emit(const AuthState.unauthenticated());
      emit(const AuthState.unknown());
    }

  }
}