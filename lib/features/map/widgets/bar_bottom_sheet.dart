import 'package:drink_diary/features/map/widgets/bar_collapsed_view.dart';
import 'package:flutter/material.dart';

import '../screens/map_screen.dart';
import 'bar_details_view.dart';

class BarBottomSheet extends StatelessWidget {
  final DraggableScrollableController controller;
  final bool isExpanded;
  final VoidCallback onExpand;
  final VoidCallback onCollapse;

  const BarBottomSheet({
    super.key,
    required this.controller,
    required this.isExpanded,
    required this.onExpand,
    required this.onCollapse,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: controller,
      initialChildSize: 0.3,
      minChildSize: 0.3,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Stack(
            children: [
              // 메인 컨텐츠
              if (!isExpanded)
                _buildCollapsedView(scrollController)
              else
                _buildExpandedView(scrollController),

              // 뒤로가기 버튼 (expanded 상태일 때만)
              if (isExpanded) _buildBackButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCollapsedView(ScrollController scrollController) {
    return BarCollapsedView(
      bar: barList[0],
      onTap: onExpand,
      scrollController: scrollController,
    );
  }

  Widget _buildExpandedView(ScrollController scrollController) {
    return ListView(
      controller: scrollController,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 84),
      children: [
        BarDetailsView(bar: barList[0]),
      ],
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 48,
      left: 16,
      child: GestureDetector(
        onTap: onCollapse,
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 20,
        ),
      ),
    );
  }
}
