import 'package:drink_diary/data/models/wine.dart';
import 'package:drink_diary/features/home/providers/category_provider.dart';
import 'package:flutter/material.dart';

import '../../data/models/drink.dart';

class DetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final DrinkCategory category;
  final Drink drink;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const DetailAppBar({
    super.key,
    required this.category,
    required this.drink,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: category.theme.iconColor,
        ),
      ),
      backgroundColor: category.theme.backgroundColor,
      title: Text(
        drink.name,
        style: TextStyle(
          color: category.theme.iconColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
            icon: Icon(
              Icons.edit,
              color: category.theme.iconColor,
            ),
            onPressed: onEdit),
        IconButton(
          icon: Icon(
            Icons.delete,
            color: category.theme.iconColor,
          ),
          onPressed: onDelete,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}
