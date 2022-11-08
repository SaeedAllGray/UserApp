part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class WaitingForInputState extends LoginState {}

class LoadingState extends LoginState {}

class LoginFailedState extends LoginState {}

class LoginSucceedState extends LoginState {}

class ShouldActicateTheButton extends LoginState {}

class ShouldDeacticateTheButton extends LoginState {}
