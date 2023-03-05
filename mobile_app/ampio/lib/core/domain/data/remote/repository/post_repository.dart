import '../../../../utils/constants/api_end_point.dart';
import '../../../entity/post_entity.dart';
import '../network_service.dart';

class PostRepository {
  final NetworkService _networkService = NetworkService();

  Future<dynamic> getPosts() async {
    final response = await _networkService.get( path: ApiEndPoint.getPosts);

    return response.data;
  }
}