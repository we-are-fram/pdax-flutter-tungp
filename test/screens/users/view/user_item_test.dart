import 'package:flutter/material.dart';
import 'package:flutter_assignment/repositories/repositories.dart';
import 'package:flutter_assignment/screens/users/view/user_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  group(UserItem, () {
    final user = User(
      firstName: 'firstName',
      lastName: 'lastName',
      email: 'email',
      image: 'image',
    );

    testWidgets('should render as expectation', (tester) async {
      await mockNetworkImages(
        () async => tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox(
              width: 200,
              height: 400,
              child: UserItem(item: user),
            ),
          ),
        ),
      );
      expect(
        find.byType(Row).evaluate().first.widget,
        isA<Row>()
            .having(
              (row) => row.children.first,
              'SizedBox',
              isA<SizedBox>()
                  .having((sizedBox) => sizedBox.width, 'with', 30)
                  .having((sizedBox) => sizedBox.height, 'height', 30)
                  .having(
                    (sizedBox) => sizedBox.child,
                    'Image',
                    isA<Image>().having(
                      (image) => (image.image as NetworkImage).url,
                      'url',
                      user.image,
                    ),
                  ),
            )
            .having(
              (row) => row.children[1],
              'SizedBox',
              isA<SizedBox>().having((sizedBox) => sizedBox.width, 'with', 8),
            )
            .having(
              (row) => row.children.last,
              'Expanded',
              isA<Expanded>().having(
                (expanded) => expanded.child,
                'Column',
                isA<Column>()
                    .having(
                      (column) => column.crossAxisAlignment,
                      'crossAxisAlignment',
                      CrossAxisAlignment.start,
                    )
                    .having(
                      (column) => column.children.first,
                      'user name',
                      isA<Text>().having(
                        (text) => text.data,
                        'data',
                        '${user.firstName} ${user.lastName}',
                      ),
                    )
                    .having(
                      (column) => column.children[1],
                      'SizedBox',
                      isA<SizedBox>().having(
                        (text) => text.height,
                        'height',
                        4,
                      ),
                    )
                    .having(
                      (column) => column.children.last,
                      'email',
                      isA<Text>().having(
                        (text) => text.data,
                        'data',
                        user.email,
                      ),
                    ),
              ),
            ),
      );
    });
  });
}
