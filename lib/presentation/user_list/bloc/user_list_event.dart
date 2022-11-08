part of 'user_list_bloc.dart';

@immutable
abstract class UserListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserListEvent extends UserListEvent {
  final Uuid uuid = Uuid();
  final int pageNo;

  GetUserListEvent(this.pageNo);
  @override
  List<Object> get props => [pageNo, uuid];
}

class ScrollEvent extends UserListEvent {
  final Uuid uuid = const Uuid();

  @override
  List<Object> get props => [uuid];
}
