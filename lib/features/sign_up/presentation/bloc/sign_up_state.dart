part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final Map<String, dynamic>? remoteConfigData;
  final String? message;

  const SignUpSuccess({this.remoteConfigData, this.message});

  @override
  List<Object?> get props => [remoteConfigData,message];
}
