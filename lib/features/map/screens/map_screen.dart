import 'package:drink_diary/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../../data/models/comment.dart';
import '../../../data/models/drinkbar.dart';

// 목업 DrinkBar 데이터
final List<DrinkBar> barList = [
  DrinkBar(
    id: '1',
    name: '루프탑 바',
    address: '서울시 강남구 역삼동 123-45',
    latitude: 37.123,
    longitude: 127.123,
    description: '도심 속 야경이 아름다운 루프탑 바입니다.',
    images: ['https://picsum.photos/400/300', 'https://picsum.photos/401/300'],
    recommendationCount: 150,
    rating: 4.5,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: AppConstants.defaultLatLng,
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.maptiler.com/maps/bright-v2/{z}/{x}/{y}.png?key=GUYdiyQdpQ43k4ckiMdH',
                userAgentPackageName: 'com.chaeyeon.drinkDiary',
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSheetVisible = true;
                  });
                },
                child: MarkerLayer(
                  markers: [
                    Marker(
                      point: AppConstants.defaultLatLng,
                      width: 30,
                      height: 60,
                      child: Image.asset('assets/icons/place_bar.png'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isSheetVisible) _buildBottomSheet(),
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    return DraggableScrollableSheet(
      controller: _controller,
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
                _buildCollapsedContent(scrollController)
              else
                _buildExpandedContent(scrollController),

              // 뒤로가기 버튼 (expanded 상태일 때만)
              if (isExpanded)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 8,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
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
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(30),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCollapsedContent(ScrollController scrollController) {
    return GestureDetector(
      onTap: () {
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
      },
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.zero,
          itemCount: barList.length,
          itemBuilder: (context, index) {
            final bar = barList[index];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    bar.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bar.address,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bar.images?.length ?? 0,
                      itemBuilder: (context, imageIndex) {
                        return Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(
                                bar.images?[imageIndex] ??
                                    'https://picsum.photos/200',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildExpandedContent(ScrollController scrollController) {
    final bar = barList[0];
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.zero,
            children: [
              // 바 정보
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bar.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 240,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: bar.images?.length ?? 0,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 180,
                            child: Image.network(
                              bar.images?[index] ?? 'https://picsum.photos/200',
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      bar.address,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 추천 수와 평점
                    Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.red),
                        const SizedBox(width: 4),
                        Text('${bar.recommendationCount}'),
                        const SizedBox(width: 16),
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text('${bar.rating}'),
                      ],
                    ),

                    if (bar.description != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        bar.description!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],

                    // 댓글 섹션
                    const SizedBox(height: 24),
                    const Text(
                      '댓글',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...bar.comments.map((comment) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.text,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                comment.userId,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
