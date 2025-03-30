import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:server_driven_ui/core/injections/injection.dart';
import 'package:server_driven_ui/core/remote_config/firebase_remote_config.dart';
import 'package:server_driven_ui/core/utils/app_strings.dart';
import 'package:server_driven_ui/features/sign_up/domain/repositories/abstract_firebase_sign_up.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AbstractFirebaseSignUp firebaseSignUp;
  SignUpBloc({required this.firebaseSignUp}) : super(SignUpInitial()) {
    on<FetchRemoteConfig>(onFetchRemoteConfig);
    on<SignUpButtonPressed>(onSignUpButtonPressed);
  }

  FutureOr<void> onFetchRemoteConfig(
    FetchRemoteConfig event,
    Emitter<SignUpState> emit,
  ) async {
    try {
      emit(SignUpLoading());

      final result = await sl<FirebaseRemoteConfigMethod>().fetchScreenJson(
        screenId: event.screenId,
      );
      log(result.toString(), name: 'Remote Config');
      emit(SignUpSuccess(remoteConfigData: result));
    } catch (e) {
      log(e.toString(), name: 'Remote Config Error');
    }
  }

  FutureOr<void> onSignUpButtonPressed(
    SignUpButtonPressed event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    try {
      final result = await firebaseSignUp.signUpWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      if (result.user?.uid.isNotEmpty ?? false) {
        emit(const SignUpSuccess(message: AppString.remoteConfigFetched));
      }
    } catch (e) {
      log(e.toString(), name: 'Remote Config Error');
    }
  }
}
