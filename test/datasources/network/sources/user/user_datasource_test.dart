import 'package:flutter_assignment/datasources/datasources.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockUserApi extends Mock implements UserApi {}

void main() {
  group(UserDatasource, () {
    late _MockUserApi mockUserApi;
    late UserDatasource datasource;
    setUp(() {
      mockUserApi = _MockUserApi();
      datasource = UserDatasourceImpl(mockUserApi);
    });
    group('.fetchUsers', () {
      const firstName = 'firstName';
      const lastName = 'lastName';
      const email = 'email';
      const image = 'image';
      const userJson = {
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'image': image,
      };
      const quantity = 2;
      const usersJson = {
        'total': 1,
        'data': [userJson],
      };
      test(
          'return the list of users when calling '
          'UserApi.fetchUsers() successfully', () async {
        when(() => mockUserApi.fetchUsers(quantity: any(named: 'quantity')))
            .thenAnswer((_) async => usersJson);
        final response = await datasource.fetchUsers(quantity: quantity);
        expect(response, isNotNull);
        verify(
          () => mockUserApi.fetchUsers(
            quantity: any(named: 'quantity', that: equals(quantity)),
          ),
        ).called(1);
      });
      test(
          'should throws an exception when calling '
          'UserApi.fetchUsers() throws an error', () async {
        when(() => mockUserApi.fetchUsers(quantity: any(named: 'quantity')))
            .thenThrow(Exception());
        expect(
          () => datasource.fetchUsers(quantity: quantity),
          throwsA(
            isA<Exception>().having(
              (exception) => exception.toString(),
              'message',
              equals('Error when calling the API to fetch users!'),
            ),
          ),
        );
      });
    });
  });
}
