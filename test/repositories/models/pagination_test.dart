import 'package:flutter_assignment/repositories/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(Pagination, () {
    const total = 90;
    const items = <dynamic>[];
    test('can be instantiated', () {
      final instance = Pagination(total: total, items: items);
      expect(instance.total, total);
      expect(instance.items, items);
    });
  });
}
