import 'package:flutter_assignment/datasources/datasources.dart';
import 'package:flutter_assignment/repositories/repositories.dart';

/// The published locator instance.
final locator = AppLocator();

final class AppLocator {
  UserApi get _userApi => UserApiImpl(ApiConfig.client);

  UserDatasource get _userDatasource => UserDatasourceImpl(_userApi);

  UserRepositoryImpl get userRepository =>
      UserRepositoryImpl(userDatasource: _userDatasource);
}
