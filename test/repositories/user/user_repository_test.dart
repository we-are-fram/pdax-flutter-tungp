import 'package:flutter_assignment/datasources/datasources.dart';
import 'package:flutter_assignment/repositories/repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockUserDatasource extends Mock implements UserDatasource {}

void main() {
  group(UserRepository, () {
    late _MockUserDatasource mockUserDatasource;
    late UserRepository repository;

    setUp(() {
      mockUserDatasource = _MockUserDatasource();
      repository = UserRepositoryImpl(userDatasource: mockUserDatasource);
    });
    group('.getUsers', () {
      const total = 1;
      const page = 2;
      const limit = 1;
      const firstName = 'firstName';
      const lastName = 'lastName';
      const email = 'email';
      const image = 'image';
      final user = UserModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        image: image,
      );
      final data = [user];
      final usersPaginationModel = PaginationModel(
        total: total,
        data: data,
      );
      test(
          'should return the list of user when calling '
          'UserDatasource.getUsers() successfully', () async {
        when(
          () => mockUserDatasource.fetchUsers(quantity: any(named: 'quantity')),
        ).thenAnswer((_) async => usersPaginationModel);
        final response = await repository.getUsers(page: page, limit: 1);
        expect(response.total, total);
        expect(response.items.first.firstName, firstName);
        expect(response.items.first.lastName, lastName);
        expect(response.items.first.email, email);
        expect(response.items.first.image, image);
        verify(
          () => mockUserDatasource.fetchUsers(
            quantity: any(named: 'quantity', that: equals(page * limit)),
          ),
        ).called(1);
      });
      test(
          'should throw $GetUsersException when calling '
          'UserDatasource.fetchUsers() throws an error', () async {
        when(
          () => mockUserDatasource.fetchUsers(quantity: any(named: 'quantity')),
        ).thenThrow(Exception());
        expect(
          () => repository.getUsers(page: page, limit: limit),
          throwsA(isA<GetUsersException>()),
        );
      });
    });
  });
}
