import 'package:flutter_assignment/repositories/repositories.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(User, () {
    const firstName = 'firstName';
    const lastName = 'lastName';
    const email = 'email';
    const image = 'image';
    test('can be instantiated', () {
      final instance = User(
        firstName: firstName,
        lastName: lastName,
        email: email,
        image: image,
      );
      expect(instance.firstName, firstName);
      expect(instance.lastName, lastName);
      expect(instance.email, email);
      expect(instance.image, image);
    });
  });
}
