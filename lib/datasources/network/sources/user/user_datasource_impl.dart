import 'package:flutter_assignment/datasources/network/apis/apis.dart';
import 'package:flutter_assignment/datasources/network/sources/models/models.dart';
import 'package:flutter_assignment/datasources/network/sources/user/models/models.dart';
import 'package:flutter_assignment/datasources/network/sources/user/user_datasource.dart';

/// {@template user_datasource_impl}
/// The implementation of [UserDatasource].
/// {@endtemplate}
final class UserDatasourceImpl implements UserDatasource {
  /// {@macro user_datasource_impl}
  UserDatasourceImpl(this._api);

  final UserApi _api;

  @override
  Future<PaginationModel<UserModel>> fetchUsers({required int quantity}) async {
    try {
      final response = await _api.fetchUsers(quantity: quantity);
      return PaginationModel.fromJson(
        json: response,
        toModel: (json) => UserModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw Exception('Error when calling the API to fetch users!');
    }
  }
}
