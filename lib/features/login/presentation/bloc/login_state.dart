part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final Map<String, dynamic>? remoteConfigData;
  final String? message;

  const LoginSuccess({this.remoteConfigData, this.message});

  @override
  List<Object?> get props => [remoteConfigData, message];
}
