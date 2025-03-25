import 'dart:io';

import 'package:flutter/material.dart';

class BuildImages extends StatelessWidget {
  final List<String>? images;
  final int index;
  final double height;
  final double width;

  const BuildImages({
    super.key,
    required this.images,
    required this.index,
    this.height = 200,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    final String? imagePath =
        (images != null && index < images!.length) ? images![index] : null;

    if (imagePath != null && imagePath.isNotEmpty) {
      return Image.file(
        File(imagePath),
        height: height,
        width: width,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/images/no_image.png',
        height: height,
        width: width,
        fit: BoxFit.fitWidth,
      );
    }
  }
}
