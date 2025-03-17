import 'package:drink_diary/features/home/providers/category_provider.dart';
import 'package:flutter/material.dart';
import '../../data/models/drink.dart';

class FormAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Drink? baseDrink;
  final String drinkName;
  final DrinkCategory category;
  final VoidCallback onSubmit;

  const FormAppBar({
    super.key,
    this.baseDrink,
    required this.onSubmit,
    required this.drinkName,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: category.theme.backgroundColor,
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
        baseDrink == null ? '$drinkName 기록 생성' : '$drinkName 기록 수정',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
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
