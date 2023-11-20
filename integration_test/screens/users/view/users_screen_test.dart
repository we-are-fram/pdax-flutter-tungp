import 'package:flutter/material.dart';
import 'package:flutter_assignment/main.dart';
import 'package:flutter_assignment/screens/screens.dart';
import 'package:flutter_assignment/screens/users/view/user_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(UsersScreen, () {
    testWidgets('User is able to scroll to the bottom of the list',
        (tester) async {
      await tester.pumpWidget(const MyApp());
      await Future<void>.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      await Future<void>.delayed(const Duration(seconds: 1));
      await tester.fling(find.byType(ListView), const Offset(0, -400), 1000);
      expect(find.byType(UserItem).evaluate(), isNotEmpty);
    });
  });
}
