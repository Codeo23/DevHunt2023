import '../../../../utils/constants/api_end_point.dart';
import '../../../entity/post_entity.dart';
import '../network_service.dart';

class PostRepository {
  final NetworkService _networkService = NetworkService();

  Future<List<PostEntity>> getPosts() async {
    final response = await _networkService.get( path: ApiEndPoint.getPosts);
    response.data.forEach((post) => PostEntity.fromJson(post));

    return response.data;
  }
}