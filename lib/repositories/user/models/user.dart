/// {@template user}
/// The information of user.
/// {@endtemplate}
final class User {
  /// {@macro user}
  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  /// Represent the first name of this user.
  final String firstName;

  /// Represent the last name of this user.
  final String lastName;

  /// Represent the email of this user.
  final String email;

  /// Represent image url for this user.
  final String image;
}
