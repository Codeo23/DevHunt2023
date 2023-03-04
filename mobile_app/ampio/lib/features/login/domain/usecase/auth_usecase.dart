import 'package:dio/dio.dart';

import '../data/repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository authRepository = AuthRepository();

  Future login(String email, String password) async {
    try {
      await authRepository.login(email, password);
      // TODO: set user state loggged in to true
    } on DioError catch (e) {
      print(e.message);
    }
  }
}