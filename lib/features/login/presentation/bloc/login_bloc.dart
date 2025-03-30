import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:server_driven_ui/core/injections/injection.dart';
import 'package:server_driven_ui/core/remote_config/firebase_remote_config.dart';
import 'package:server_driven_ui/features/login/domain/repositories/abstract_firebase_login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AbstractFirebaseLogin firebaseLogin;
  LoginBloc({required this.firebaseLogin}) : super(LoginInitial()) {
    on<FetchRemoteConfig>(onFetchRemoteConfig);
    on<LoginButtonPressed>(onLoginButtonPressed);
  }

  FutureOr<void> onFetchRemoteConfig(
    FetchRemoteConfig event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final result = await sl<FirebaseRemoteConfigMethod>().fetchScreenJson(
        screenId: event.screenId,
      );
      log(result.toString(), name: 'Remote Config');
      emit(LoginSuccess(remoteConfigData: result));
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
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
