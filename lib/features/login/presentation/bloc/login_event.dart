part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class FetchRemoteConfig extends LoginEvent {
  final String screenId;

  const FetchRemoteConfig({required this.screenId});

  @override
  List<Object?> get props => [screenId];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  final Map<String, dynamic>? remoteConfigData;

  const LoginButtonPressed({
    required this.email,
    required this.password,
    required this.remoteConfigData,
  });

  @override
  List<Object?> get props => [email, password, remoteConfigData];
}
