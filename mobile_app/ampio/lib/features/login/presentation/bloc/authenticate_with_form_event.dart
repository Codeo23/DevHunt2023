import '../../../../core/presentation/bloc/user/user_bloc.dart';

class AuthenticateWithFormEvent extends AuthEvent {
  final String identity;
  final String password;

  const AuthenticateWithFormEvent({required this.identity, required this.password});

  @override
  List<Object> get props => [identity, password];
}