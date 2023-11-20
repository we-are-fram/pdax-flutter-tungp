import 'package:flutter_assignment/datasources/datasources.dart';
import 'package:test/test.dart';

void main() {
  group(UserModel, () {
    const firstName = 'firstName';
    const lastName = 'lastName';
    const email = 'email';
    const image = 'image';
    const userJson = {
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'image': image,
    };
    test('can be deserializable', () {
      final instance = UserModel.fromJson(userJson);
      expect(instance.firstName, firstName);
      expect(instance.lastName, lastName);
      expect(instance.email, email);
      expect(instance.image, image);
    });
  });
}
