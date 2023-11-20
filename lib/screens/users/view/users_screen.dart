import 'package:flutter/material.dart';
import 'package:flutter_assignment/locator/locator.dart';
import 'package:flutter_assignment/screens/users/cubit/users_cubit.dart';
import 'package:flutter_assignment/screens/users/view/user_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  // coverage:ignore-start
  static Widget route() => BlocProvider(
        create: (context) => UsersCubit(
          userRepository: locator.userRepository,
        )..loadUsers(),
        child: const UsersScreen(),
      ); // coverage:ignore-end

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _controller = ScrollController();

  UsersCubit get _cubit => context.read<UsersCubit>();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels > 0 && _controller.position.outOfRange) {
        _cubit.loadUsers();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            controller: _controller,
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              return UserItem(item: state.users[index]);
            },
            itemCount: state.users.length,
          );
        },
      ),
    );
  }
}
