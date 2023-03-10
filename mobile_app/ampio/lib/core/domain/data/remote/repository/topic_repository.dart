import 'package:ampio/core/domain/data/remote/network_service.dart';
import 'package:ampio/core/utils/constants/api_end_point.dart';

class TopicRepository {
  final NetworkService _networkService = NetworkService();

  Future<dynamic> getTopics() async {
    final response = await _networkService.get( path: ApiEndPoint.topics);

    return response.data;
  }
}