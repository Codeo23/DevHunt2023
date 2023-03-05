import 'package:dio/dio.dart';

import '../../../../core/domain/data/remote/repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository authRepository = AuthRepository();

  Future loginViaForm(String email, String password) async {
    try {
      await authRepository.login(email, password);
    } on DioError catch (e) {
      print(e.message);
    }
  }
}