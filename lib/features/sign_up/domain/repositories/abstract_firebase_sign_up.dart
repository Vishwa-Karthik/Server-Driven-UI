import 'package:firebase_auth/firebase_auth.dart';

abstract class AbstractFirebaseSignUp {
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });
}
