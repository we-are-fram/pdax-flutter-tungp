import 'package:flutter_assignment/datasources/network/sources/models/models.dart';
import 'package:test/test.dart';

void main() {
  group(PaginationModel, () {
    const total = 90;
    const data = <dynamic>[];
    const paginationJson = {
      'data': data,
      'total': total,
    };
    test('can be deserializable', () {
      final instance = PaginationModel.fromJson(
        json: paginationJson,
        toModel: (json) => '',
      );
      expect(instance.total, total);
      expect(instance.data, data);
    });
  });
}
