import 'package:dio/dio.dart';
import 'package:flutter_assignment/datasources/network/apis/user/user_api.dart';

/// {@template user_api_impl}
/// The implementation of [UserApi].
/// {@endtemplate}
final class UserApiImpl implements UserApi {
  /// {@macro user_api_impl}
  UserApiImpl(this._dio);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> fetchUsers({required int quantity}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/users',
        queryParameters: {
          '_quantity': quantity,
        },
      );
      return response.data!;
    } catch (e) {
      throw Exception('Error when calling the endpoint "/users"!');
    }
  }
}
