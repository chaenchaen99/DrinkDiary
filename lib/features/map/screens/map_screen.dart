import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/comment.dart';
import '../../../data/models/drinkbar.dart';
import '../../../features/map/widgets/bar_bottom_sheet.dart';
import '../widgets/map_view.dart';

// 목업 DrinkBar 데이터
final List<DrinkBar> barList = [
  DrinkBar(
    id: '1',
    name: '루프탑 바',
    address: '서울시 강남구 역삼동 123-45',
    latitude: 37.123,
    longitude: 127.123,
    description: '도심 속 야경이 아름다운 루프탑 바입니다.어찌고저찌고',
    onelineReview: '도심 속 야경이 아름다운 루프탑 바입니다.',
    images: ['https://picsum.photos/400/300', 'https://picsum.photos/401/300'],
    recommendationCount: 150,
    phone: '01096451697',
    comments: [
      Comment(
          id: '1',
          text: '분위기가 너무 좋아요!',
          userId: 'user1',
          createdAt: DateTime.now()),
      Comment(
          id: '2',
          text: '칵테일이 맛있어요',
          userId: 'user2',
          createdAt: DateTime.now()),
    ],
    link: 'https://instagram.com/rooftop_bar',
    createdAt: DateTime.now(),
    createdBy: 'admin',
  ),
];

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  bool isExpanded = false;
  bool isSheetVisible = false;

  void _handleMarkerTap() {
    setState(() {
      isSheetVisible = true;
    });
  }

  void _handleExpand() {
    setState(() {
      isExpanded = true;
    });
    Future.delayed(const Duration(milliseconds: 50), () {
      _controller.animateTo(
        1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _handleCollapse() {
    setState(() {
      isExpanded = false;
    });
    Future.delayed(const Duration(milliseconds: 50), () {
      _controller.animateTo(
        0.3,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapView(
            onMarkerTap: _handleMarkerTap,
          ),
          if (isSheetVisible)
            BarBottomSheet(
                controller: _controller,
                isExpanded: isExpanded,
                onExpand: _handleExpand,
                onCollapse: _handleCollapse),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
