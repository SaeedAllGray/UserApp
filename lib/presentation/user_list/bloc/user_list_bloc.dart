import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_app/application/user_list_service.dart';
import 'package:user_app/domain/user/user.dart';
import 'package:uuid/uuid.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  List<User> userList = [];
  int pageNumber = 1;
  UserListBloc() : super(UserListNotLoadedState()) {
    on<GetUserListEvent>(_emitGetUserList);
    on<ScrollEvent>(_emitScrollEvent);
  }

  FutureOr<void> _emitGetUserList(
      GetUserListEvent event, Emitter<UserListState> emit) async {
    // emit(UserListIsLoadingState());
    userList.addAll(await UserService.getUserList(event.pageNo));
    pageNumber++;
    if (userList.isEmpty) {
      emit(UserListNotLoadedState());
    } else {
      emit(UserListLoadedState(userList));
    }
  }

  FutureOr<void> _emitScrollEvent(
      ScrollEvent event, Emitter<UserListState> emit) {
    pageNumber++;
  }
}
