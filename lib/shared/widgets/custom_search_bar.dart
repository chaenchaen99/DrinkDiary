import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';

class SearchInputTextfield extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final VoidCallback onClose;
  final Function(String) onSubmit;

  const SearchInputTextfield({
    super.key,
    required this.onSubmit,
    required this.controller,
    required this.onClose,
  });

  @override
  ConsumerState<SearchInputTextfield> createState() =>
      _SearchInputTextfieldState();
}

class _SearchInputTextfieldState extends ConsumerState<SearchInputTextfield> {
  @override
  Widget build(BuildContext context) {
    var searchBarPadding = 40;
    return SizedBox(
      width: MediaQuery.of(context).size.width - searchBarPadding,
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.search,
              controller: widget.controller,
              onSubmitted: widget.onSubmit,
              style: const TextStyle(
                fontFamily: 'Pretendard',
                color: AppColors.grey500,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  // 포커스 상태에서의 border 색상
                  borderRadius: BorderRadius.all(Radius.circular(28)),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                    borderSide: BorderSide.none),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.search_rounded,
                    color: AppColors.grey500,
                    size: 18,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                hintText: '검색어를 입력해주세요',
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: widget.onClose,
            child: const Text(
              '취소',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
