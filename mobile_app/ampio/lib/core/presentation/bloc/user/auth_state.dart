part of 'user_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

extension AuthStatusExtension on AuthStatus {
  bool get isUnknown => this == AuthStatus.unknown;
  bool get isAuthenticated => this == AuthStatus.authenticated;
  bool get isUnauthenticated => this == AuthStatus.unauthenticated;
}

class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity? user;

  const AuthState._({
    required this.status,
    this.user,
  });

  const AuthState.unknown() : this._(status: AuthStatus.unknown);

  const AuthState.authenticated(UserEntity user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];
}