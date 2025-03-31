// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  SignUpSuccess copyWith({
    Map<String, dynamic>? remoteConfigData,
    String? message,
  }) {
    return SignUpSuccess(
      remoteConfigData: remoteConfigData ?? this.remoteConfigData,
      message: message ?? this.message,
    );
  }
}
