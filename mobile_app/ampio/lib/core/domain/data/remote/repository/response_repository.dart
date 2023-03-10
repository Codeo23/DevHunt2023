import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../utils/constants/api_end_point.dart';
import '../network_service.dart';

class ResponseRepository {
  final NetworkService _networkService = NetworkService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<dynamic> getAllComments({required int post_id}) async {
    final response = await _networkService.get(
      path: '/comments/1',
    );
    return response.data;
  }

  Future<dynamic> addComment({
    String? content,
    String? filePath,
  }) async {
    final token = await _secureStorage.read(key: 'token');
    final response = await _networkService.post(
      path: ApiEndPoint.postComments,
      data: FormData.fromMap({
        "content": content,
        "file":
            filePath != null ? await MultipartFile.fromFile(filePath) : null,
      }),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}
