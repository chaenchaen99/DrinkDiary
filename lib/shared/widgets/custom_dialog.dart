import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<CustomDialogAction> actions;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.delete,
            color: Colors.grey.shade800,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade800,
              )),
        ],
      ),
      content: Text(content,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade800,
          )),
      actions: actions.asMap().entries.map((entry) {
        final index = entry.key;
        final action = entry.value;
        return TextButton(
          child: Text(
            action.text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: index == 1
                  ? AppColors.error
                  : Colors.grey.shade800, // 두 번째 버튼을 빨간색으로
            ),
          ),
          onPressed: () => Navigator.of(context).pop(action.value),
        );
      }).toList(),
    );
  }
}

class CustomDialogAction {
  final String text;
  final dynamic value;

  CustomDialogAction({required this.text, required this.value});
}
