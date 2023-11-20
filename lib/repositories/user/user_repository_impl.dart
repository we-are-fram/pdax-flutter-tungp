import 'package:flutter_assignment/datasources/datasources.dart';
import 'package:flutter_assignment/repositories/models/pagination.dart';
import 'package:flutter_assignment/repositories/user/exceptions/exceptions.dart';
import 'package:flutter_assignment/repositories/user/models/models.dart';
import 'package:flutter_assignment/repositories/user/user_repository.dart';

/// {@template user_repository_impl}
/// The implementation of [UserRepository].
/// {@endtemplate}
final class UserRepositoryImpl implements UserRepository {
  /// {@macro user_repository_impl}
  const UserRepositoryImpl({
    required UserDatasource userDatasource,
  }) : _userDatasource = userDatasource;
  final UserDatasource _userDatasource;

  @override
  Future<Pagination<User>> getUsers({int page = 1, int limit = 10}) async {
    try {
      final response = await _userDatasource.fetchUsers(quantity: page * limit);
      return Pagination(
        total: response.total,
        items: response.data
            .map(
              (user) => User(
                firstName: user.firstName,
                lastName: user.lastName,
                email: user.email,
                image: user.image,
              ),
            )
            .toList(),
      );
    } catch (e) {
      throw GetUsersException();
    }
  }
}
