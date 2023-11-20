import 'package:flutter_assignment/cores/cores.dart';
import 'package:flutter_assignment/repositories/repositories.dart';
import 'package:flutter_assignment/screens/users/cubit/users_cubit.dart';
import 'package:test/test.dart';

void main() {
  group(UsersState, () {
    late UsersState instance;
    setUp(() {
      instance = UsersState();
    });
    test('can be instantiated', () {
      expect(instance.status, DataLoadStatus.loading);
      expect(instance.users, isEmpty);
    });
    test('can be comparable', () {
      expect(instance.props, orderedEquals([instance.status, instance.users]));
    });
    test('can be modifiable', () {
      final users = [
        User(
          firstName: 'firstName',
          lastName: 'lastName',
          email: 'email',
          image: 'image',
        ),
      ];
      expect(
        instance.copyWith(status: DataLoadStatus.failure, users: users),
        UsersState(
          status: DataLoadStatus.failure,
          users: users,
        ),
      );
      expect(instance.copyWith(), instance);
    });
  });
}
