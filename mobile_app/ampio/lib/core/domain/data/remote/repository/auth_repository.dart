import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../utils/constants/api_end_point.dart';
import '../network_service.dart';

class AuthRepository {

  final NetworkService _networkService = NetworkService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<dynamic> login(String identity, String password) async {

    final response = await _networkService.post(
      path: ApiEndPoint.authentication,
      data: FormData.fromMap({
        'identity': identity,
        'password': password,
      })
    );

    return response.data;
  }

  Future<dynamic> getCurrentUser() async {
    final token = await _secureStorage.read(key: 'token');

    final response = await _networkService.get(
      path: ApiEndPoint.currentUser,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
      )
    );

    return response.data['data'];
  }
}