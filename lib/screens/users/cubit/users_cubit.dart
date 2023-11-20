import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_assignment/cores/cores.dart';
import 'package:flutter_assignment/repositories/repositories.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(UsersState(users: []));

  final UserRepository _userRepository;
  int? _page;

  @visibleForTesting
  // ignore: avoid_setters_without_getters
  set page(int value) {
    _page = value;
  }

  int get _nextPage => (_page ?? 0) + 1;

  final _limit = 20;

  Future<void> loadUsers() async {
    try {
      if (_page != null && state.status == DataLoadStatus.loading) {
        return;
      }
      emit(state.copyWith(status: DataLoadStatus.loading));
      final pagination =
          await _userRepository.getUsers(page: _nextPage, limit: _limit);
      _page ??= 0;
      _page = _page! + 1;
      emit(
        state.copyWith(
          users: pagination.items,
          status: DataLoadStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: DataLoadStatus.failure));
    }
  }
}
