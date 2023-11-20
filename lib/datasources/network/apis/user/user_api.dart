/// The endpoints for user domain.
abstract interface class UserApi {
  /// Return the response of user list.
  ///
  /// Throw [Exception] if calling the endpoint fails for some reasons.
  Future<Map<String, dynamic>> fetchUsers({required int quantity});
}
