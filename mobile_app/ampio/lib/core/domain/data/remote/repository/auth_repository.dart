import '../../../../utils/constants/api_end_point.dart';
import '../network_service.dart';

class AuthRepository {

  final NetworkService _networkService = NetworkService();

  Future<dynamic> login(String identity, String password) async {

    final response = await _networkService.post(
      path: ApiEndPoint.authentication,
      data: {
        'identity': identity,
        'password': password,
      }
    );

    return response.data;
  }
}