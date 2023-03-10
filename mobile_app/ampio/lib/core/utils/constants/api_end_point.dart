abstract class ApiEndPoint {
  static const authentication = '/auth/login';
  static const currentUser = '/users/me';
  static const getPosts = '/posts';
  static const addPost = '/posts/publish';

  static const getComments = '/comments';
  // TODO : Dynamics 1
  static const postComments = '/comments/1/comment';
}