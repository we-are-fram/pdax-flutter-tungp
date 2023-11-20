import 'package:flutter_assignment/repositories/repositories.dart';

/// The repository that handles user domain.
abstract interface class UserRepository {
  /// Get the list of users.
  ///
  /// Throw [GetUsersException] when getting the list of users fails.
  Future<Pagination<User>> getUsers({int page = 1, int limit = 10});
}
