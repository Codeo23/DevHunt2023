import 'package:dio/dio.dart';

import '../../../../../core/domain/data/remote/network_service.dart';
import '../../../../../core/utils/constants/api_end_point.dart';

class AuthRepository {

  final _networkService = NetworkService();

  Future<Response> login(String username, String password) async {
    final response = await _networkService.post(
      path: ApiEndPoint.authentication,
      data: {
        'identity': username,
        'password': password,
      },
    );

    return response;
  }

  Future<Response> getCurrentUser() async {
    final response = await _networkService.get(
      path: ApiEndPoint.currentUser,
    );

    return response;
  }
}