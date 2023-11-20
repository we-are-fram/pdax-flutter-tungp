import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_assignment/cores/cores.dart';
import 'package:flutter_assignment/repositories/repositories.dart';
import 'package:flutter_assignment/screens/users/cubit/users_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockUserRepository extends Mock implements UserRepository {}

void main() {
  group(UsersCubit, () {
    late _MockUserRepository mockUserRepository;
    late UsersCubit cubit;
    setUp(() {
      mockUserRepository = _MockUserRepository();
      cubit = UsersCubit(userRepository: mockUserRepository);
    });
    group('.loadUsers', () {
      blocTest<UsersCubit, UsersState>(
        'should emit ${DataLoadStatus.success} when calling '
        'UserRepository.getUsers() successfully',
        build: () => cubit,
        setUp: () {
          when(
            () => mockUserRepository.getUsers(
              page: any(named: 'page'),
              limit: any(named: 'limit'),
            ),
          ).thenAnswer(
            (_) async => Pagination(total: 2, items: <User>[]),
          );
        },
        act: (cubit) => cubit.loadUsers(),
        expect: () => [
          isA<UsersState>().having(
            (state) => state.status,
            'status',
            DataLoadStatus.loading,
          ),
          isA<UsersState>().having(
            (state) => state.status,
            'status',
            DataLoadStatus.success,
          ),
        ],
        verify: (cubit) {
          verify(
            () => mockUserRepository.getUsers(
              page: any(named: 'page', that: equals(1)),
              limit: any(named: 'limit', that: equals(20)),
            ),
          ).called(1);
        },
      );
      blocTest<UsersCubit, UsersState>(
        'should emit ${DataLoadStatus.failure} when calling '
        'UserRepository.getUsers() throws $GetUsersException',
        build: () => cubit,
        setUp: () {
          when(
            () => mockUserRepository.getUsers(
              page: any(named: 'page'),
              limit: any(named: 'limit'),
            ),
          ).thenThrow(GetUsersException());
        },
        act: (cubit) => cubit.loadUsers(),
        expect: () => [
          isA<UsersState>(),
          isA<UsersState>().having(
            (state) => state.status,
            'status',
            DataLoadStatus.failure,
          ),
        ],
      );
      blocTest<UsersCubit, UsersState>(
        'should not emit new state when current status '
        'is ${DataLoadStatus.loading} and current page is not null',
        build: () => cubit,
        setUp: () {
          cubit.page = 1;
        },
        act: (cubit) => cubit.loadUsers(),
        expect: () => isEmpty,
      );
    });
  });
}
