part of 'user_list_bloc.dart';

@immutable
abstract class UserListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserListNotLoadedState extends UserListState {}

class UserListIsLoadingState extends UserListState {}

class UserListLoadedState extends UserListState {
  final Uuid uuid = Uuid();
  final List<User> userList;
  UserListLoadedState(this.userList);

  @override
  List<Object> get props => [uuid];
}
