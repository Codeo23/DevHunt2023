import 'package:dio/dio.dart';

import '../../../../utils/constants/api_end_point.dart';
import '../network_service.dart';

class PostRepository {
  final NetworkService _networkService = NetworkService();

  Future<Response> getPosts() async {
    final response = await _networkService.get( path: ApiEndPoint.getPosts);
    return response;
  }
}