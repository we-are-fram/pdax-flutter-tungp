import 'package:dio/dio.dart';
import 'package:flutter_assignment/datasources/datasources.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../mocks/dio_mock.dart';

void main() {
  group(UserApi, () {
    late MockDio mockDio;
    late UserApi api;

    setUp(() {
      mockDio = MockDio();
      api = UserApiImpl(mockDio);
    });

    test('can be instantiated', () {
      expect(api, isNotNull);
    });

    group('.fetchUsers', () {
      const quantity = 1;
      final response =
          Response(requestOptions: RequestOptions(), data: <String, dynamic>{});
      test(
          'should return the response when calling the endpoint '
          '"/users" successfully', () async {
        when(
          () => mockDio.get<Map<String, dynamic>>(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer((_) async => response);
        final resp = await api.fetchUsers(quantity: quantity);
        expect(resp, response.data);
        verify(
          () => mockDio.get<Map<String, dynamic>>(
            any(that: equals('/users')),
            queryParameters: any(
              named: 'queryParameters',
              that: equals({
                '_quantity': quantity,
              }),
            ),
          ),
        ).called(1);
      });
      test('should throw exception when calling the point fails', () {
        when(() => mockDio.get<Map<String, dynamic>>(any()))
            .thenThrow(DioException(requestOptions: RequestOptions()));
        expect(
          () => api.fetchUsers(quantity: quantity),
          throwsA(
            isA<Exception>().having(
              (exception) => exception.toString(),
              'message',
              'Exception: Error when calling the endpoint "/users"!',
            ),
          ),
        );
      });
    });
  });
}
