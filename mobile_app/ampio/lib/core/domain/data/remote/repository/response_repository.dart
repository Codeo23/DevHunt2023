import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../utils/constants/api_end_point.dart';
import '../network_service.dart';

class ResponseRepository {
  final NetworkService _networkService = NetworkService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<dynamic> getAllComments({required String postId}) async {
    final response = await _networkService.get(
      path: '${ApiEndPoint.comments}/$postId',
    );
    return response.data;
  }

  Future<dynamic> addComment({
    String? content,
    String? filePath,
    required String postId
  }) async {
    final token = await _secureStorage.read(key: 'token');
    final response = await _networkService.post(
      path: '${ApiEndPoint.comments}/$postId/comment',
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
