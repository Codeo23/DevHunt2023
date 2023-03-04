import 'package:dio/dio.dart';

import '../../../config/network_config.dart';

class NetworkService {
  final Dio _dio;

  NetworkService(this._dio) {
    _dio.options.baseUrl = NetworkConfig.baseUrl;
    _dio.options.connectTimeout = const Duration(milliseconds: NetworkConfig.connectTimeout);
    _dio.options.receiveTimeout = const Duration(milliseconds: NetworkConfig.receiveTimeout);
  }

  Future<void> get(String path) async {
    await _dio.get(path);
  }

  Future<void> post(String path, dynamic data) async {
    await _dio.post(path, data: data);
  }
}