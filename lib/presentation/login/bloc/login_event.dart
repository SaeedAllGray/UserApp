part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginWithEmailEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class ValidateEmailAndPasswordEvent extends LoginEvent {
  final String email;
  final String password;

  const ValidateEmailAndPasswordEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
