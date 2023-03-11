import '../entity/response_entity.dart';
import '../data/remote/repository/response_repository.dart';

class ResponseUseCase {
  final ResponseRepository responseRepository = ResponseRepository();

  Future<List<ResponseEntity>> convertResponseDataToResponseEntity(
      {required String postId}) async {
    final responses = await responseRepository.getAllComments(postId: postId)
        as List<dynamic>;
    List<ResponseEntity> allResponses = [];

    for (var e in responses) {
      allResponses.add(ResponseEntity.fromJson(e));
    }
    return allResponses;
  }
}
