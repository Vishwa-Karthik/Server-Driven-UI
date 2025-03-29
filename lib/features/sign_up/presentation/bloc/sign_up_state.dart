part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String message;

  const SignUpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class SignUpEmailAlreadyInUse extends SignUpState {
  final String error;

  const SignUpEmailAlreadyInUse({required this.error});

  @override
  List<Object?> get props => [error];
}

class SignUpWeakPassword extends SignUpState {
  final String error;

  const SignUpWeakPassword({required this.error});

  @override
  List<Object?> get props => [error];
}

class SignUpInvalidEmail extends SignUpState {
  final String error;

  const SignUpInvalidEmail({required this.error});

  @override
  List<Object?> get props => [error];
}

class SignUpUnknownError extends SignUpState {
  final String error;

  const SignUpUnknownError({required this.error});

  @override
  List<Object?> get props => [error];
}
