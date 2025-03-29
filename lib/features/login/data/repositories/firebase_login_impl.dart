import 'package:firebase_auth/firebase_auth.dart';
import 'package:server_driven_ui/features/login/domain/repositories/abstract_firebase_login.dart';

class FirebaseLoginImpl implements AbstractFirebaseLogin {
  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } catch (e) {
      throw Exception('Failed to log-in: $e');
    }
  }
}
