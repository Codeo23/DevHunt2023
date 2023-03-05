import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {

  Future<UserCredential> login(String username, String password) async {

    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: username,
      password: password,
    );

    return credential;
  }
}