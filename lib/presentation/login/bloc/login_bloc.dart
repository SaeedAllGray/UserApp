import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_app/application/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(WaitingForInputState()) {
    on<LoginWithEmailEvent>(_emitLoginWithEmailEvent);
    on<ValidateEmailAndPasswordEvent>(_emitValidateEmailAndPasswordEvent);
  }

  FutureOr<void> _emitLoginWithEmailEvent(
      LoginWithEmailEvent event, Emitter<LoginState> emit) async {
    emit(LoadingState());
    String token =
        await AuthService.loginwithEmail(event.email, event.password);
    if (token.isEmpty) {
      emit(ShouldActicateTheButton());
      emit(LoginFailedState());
    } else {
      emit(LoginSucceedState());
    }
  }

  FutureOr<void> _emitValidateEmailAndPasswordEvent(
      ValidateEmailAndPasswordEvent event, Emitter<LoginState> emit) {
    final RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (event.password.length > 7 && emailRegExp.hasMatch(event.email)) {
      emit(ShouldActicateTheButton());
    } else {
      emit(ShouldDeacticateTheButton());
    }
  }
}
