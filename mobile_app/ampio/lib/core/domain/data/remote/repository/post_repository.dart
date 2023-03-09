import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../utils/constants/api_end_point.dart';
import '../../../entity/post_entity.dart';
import '../network_service.dart';

class PostRepository {
  final NetworkService _networkService = NetworkService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<dynamic> getPosts() async {
    final response = await _networkService.get( path: ApiEndPoint.getPosts);

    return response.data;
  }

  Future<dynamic> addPost({
    String? question,
    String? description,
    String? topic,
    String? filePath
  }) async {
    final token = await _secureStorage.read(key: 'token');
    final response = await _networkService.post(
      path: ApiEndPoint.addPost,
      data: FormData.fromMap({
        "title": question,
        "content": description,
        "topics": topic,
        "file": filePath != null ? MultipartFile.fromFile(filePath) : null
      }),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
      )
    );

    return response.data;
  }
}