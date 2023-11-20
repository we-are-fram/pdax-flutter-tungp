import 'package:flutter_assignment/datasources/network/sources/models/models.dart';
import 'package:flutter_assignment/datasources/network/sources/user/models/models.dart';

/// The network datasource for getting the data which is relevant to
/// user.
abstract interface class UserDatasource {
  /// Return the list of users.
  ///
  /// Throw [Exception] if calling the API fails for some reasons.
  Future<PaginationModel<UserModel>> fetchUsers({required int quantity});
}
