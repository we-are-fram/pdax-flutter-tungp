import 'package:flutter/material.dart';
import 'package:flutter_assignment/repositories/repositories.dart';

class UserItem extends StatelessWidget {
  const UserItem({required this.item, super.key});

  final User item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox.square(
          dimension: 30,
          child: Image.network(
            item.image,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${item.firstName} ${item.lastName}'),
              const SizedBox(height: 4),
              Text(item.email),
            ],
          ),
        ),
      ],
    );
  }
}
