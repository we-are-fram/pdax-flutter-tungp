import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/repositories/repositories.dart';
import 'package:flutter_assignment/screens/screens.dart';
import 'package:flutter_assignment/screens/users/cubit/users_cubit.dart';
import 'package:flutter_assignment/screens/users/view/user_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class _MockUsersCubit extends MockCubit<UsersState> implements UsersCubit {}

void main() {
  group(UsersScreen, () {
    late _MockUsersCubit mockUsersCubit;
    setUp(() {
      final user = User(
        firstName: 'firstName',
        lastName: 'lastName',
        email: 'email',
        image: 'image',
      );
      final initialState =
          UsersState(users: List.generate(10, (index) => user));
      mockUsersCubit = _MockUsersCubit();
      whenListen(
        mockUsersCubit,
        Stream.value(initialState),
        initialState: initialState,
      );
      when(() => mockUsersCubit.loadUsers()).thenAnswer((invocation) async {});
    });

    testWidgets('should load the next page when scrolling to  as expectation',
        (tester) async {
      await mockNetworkImages(
        () async => tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<UsersCubit>(
              create: (context) => mockUsersCubit,
              child: const UsersScreen(),
            ),
          ),
        ),
      );
      expect(
        find.byType(Scaffold).evaluate().first.widget,
        isA<Scaffold>().having(
          (scaffold) => scaffold.appBar,
          'AppBar',
          isA<AppBar>()
              .having(
                (appBar) => appBar.title,
                'Text',
                isA<Text>().having((text) => text.data, 'text', 'Users').having(
                      (text) => text.style,
                      'text style',
                      const TextStyle(color: Colors.white),
                    ),
              )
              .having(
                (appBar) => appBar.backgroundColor,
                'appbar background color',
                Colors.blue,
              ),
        ),
      );

      expect(
        find.byType(ListView).evaluate().first.widget,
        isA<ListView>().having(
          (listView) => listView.padding,
          'padding',
          const EdgeInsets.all(16),
        ),
      );

      expect(find.byType(UserItem).evaluate(), isNotEmpty);
    });

    testWidgets('should load the next page when scrolling out of range',
        (tester) async {
      await mockNetworkImages(
        () async => tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<UsersCubit>(
              create: (context) => mockUsersCubit,
              child: const UsersScreen(),
            ),
          ),
        ),
      );
      await tester.fling(find.byType(ListView), const Offset(0, -500), 10000);
      verify(() => mockUsersCubit.loadUsers());
    });
  });
}
