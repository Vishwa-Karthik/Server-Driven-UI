import 'package:firebase_auth/firebase_auth.dart';
import 'package:server_driven_ui/features/sign_up/domain/repositories/abstract_firebase_sign_up.dart';

class FirebaseSignUpImpl implements AbstractFirebaseSignUp {
  @override
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }
}
