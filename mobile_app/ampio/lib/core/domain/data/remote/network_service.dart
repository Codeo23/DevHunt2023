import 'package:dio/dio.dart';

import '../../../config/network_config.dart';

class NetworkService {
  final Dio _dio = Dio();

  NetworkService() {
    _dio.options.baseUrl = NetworkConfig.baseUrl;
    _dio.options.connectTimeout = const Duration(milliseconds: NetworkConfig.connectTimeout);
    _dio.options.receiveTimeout = const Duration(milliseconds: NetworkConfig.receiveTimeout);
  }

  Future<Response> get({required String path, dynamic data, Options? options}) async {
    return await _dio.get(path, data: data, options: options);
  }

  Future<Response> post({required String path, dynamic data, Options? options}) async {
    return await _dio.post(path, data: data, options: options);
  }
}