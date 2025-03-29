import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:server_driven_ui/features/login/domain/repositories/abstract_firebase_login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AbstractFirebaseLogin firebaseLogin;
  LoginBloc({required this.firebaseLogin}) : super(LoginInitial()) {
    on<LoginButtonPressed>(onLoginButtonPressed);
  }

  FutureOr<void> onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      await firebaseLogin.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(const LoginSuccess(message: 'Login Successful'));
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
