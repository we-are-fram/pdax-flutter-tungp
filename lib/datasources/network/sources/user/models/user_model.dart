/// {@template user_model}
/// The model that is used to deserialize the response of User.
/// {@endtemplate}
final class UserModel {
  UserModel({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.image = '',
  });

  /// Convert the Map<String, dynamic> to an instance of [UserModel].
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json['firstname'] as String? ?? '',
        lastName: json['lastname'] as String? ?? '',
        email: json['email'] as String? ?? '',
        image: json['image'] as String? ?? '',
      );

  /// Represent the first name of this user.
  final String firstName;

  /// Represent the last name of this user.
  final String lastName;

  /// Represent the email of this user.
  final String email;

  /// Represent image url for this user.
  final String image;
}
