import 'package:flutter/material.dart';

class BarImageGallery extends StatelessWidget {
  final List<String>? images;
  final double height;
  final double imageWidth;

  const BarImageGallery({
    super.key,
    required this.images,
    this.height = 240,
    this.imageWidth = 180,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images?.length ?? 0,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: imageWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(images?[index] ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            clipBehavior: Clip.hardEdge,
          );
        },
      ),
    );
  }
}
