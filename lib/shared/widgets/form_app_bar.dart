import 'package:flutter/material.dart';
import '../../data/models/wine.dart';

class FormAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Wine? wine;
  final VoidCallback onSubmit;

  const FormAppBar({
    super.key,
    this.wine,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        wine == null ? '와인 기록' : '와인 기록 수정',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.check,
            color: Colors.white,
          ),
          onPressed: onSubmit,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
