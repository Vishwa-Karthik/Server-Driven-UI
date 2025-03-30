part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class FetchRemoteConfig extends SignUpEvent {
  final String screenId;

  const FetchRemoteConfig({required this.screenId});

  @override
  List<Object> get props => [screenId];
}

class SignUpButtonPressed extends SignUpEvent {
  final String email;
  final String password;

  const SignUpButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}