part of 'users_cubit.dart';

final class UsersState with EquatableMixin {
  UsersState({
    this.status = DataLoadStatus.loading,
    this.users = const [],
  });

  final DataLoadStatus status;
  final List<User> users;

  @override
  List<Object> get props => [status, users];

  UsersState copyWith({
    DataLoadStatus? status,
    List<User>? users,
  }) {
    return UsersState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }
}
