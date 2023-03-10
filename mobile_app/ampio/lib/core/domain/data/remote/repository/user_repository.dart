import '../../../../utils/constants/api_end_point.dart';
import '../network_service.dart';

class UserRepository {

  final NetworkService _networkService = NetworkService();

  Future<dynamic> getUserById(int id) async {
    final response = await _networkService.get(
      path: ApiEndPoint.getUserById + id.toString(),
    );

    return response.data['data'];
  }

}