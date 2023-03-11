import '../data/remote/repository/post_repository.dart';
import '../data/remote/repository/user_repository.dart';
import '../entity/post_entity.dart';

class PostUseCase {

  final PostRepository postRepository = PostRepository();
  final UserRepository userRepository = UserRepository();

  Future<List<PostEntity>> convertPostsDataToPostEntity() async {

    final posts = await postRepository.getPosts() as List<dynamic>;
    List<PostEntity> allPosts = [];

    for (var e in posts) {
      final user = await userRepository.getUserById(e['author_id']) as Map<String, dynamic>;
      e['author'] = user;
      allPosts.add(PostEntity.fromJson(e));
    }

    return allPosts;
  }
}