import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_drinkdiary/core/constants/app_colors.dart';
import 'package:flutter_drinkdiary/core/constants/app_sizes.dart';
import 'package:flutter_drinkdiary/core/constants/app_strings.dart';

class ImagePickerWidget extends StatelessWidget {
  final List<String> images;
  final Function(List<String>) onImagesChanged;
  final double height;
  final double width;

  const ImagePickerWidget({
    super.key,
    required this.images,
    required this.onImagesChanged,
    this.height = AppSizes.imagePreviewSize,
    this.width = AppSizes.imagePreviewSize,
  });

  Future<void> _pickImage(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        onImagesChanged([...images, image.path]);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void _removeImage(int index) {
    final newImages = List<String>.from(images);
    newImages.removeAt(index);
    onImagesChanged(newImages);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.photo,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSizes.paddingXS),
        SizedBox(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length + 1,
            itemBuilder: (context, index) {
              if (index == images.length) {
                return GestureDetector(
                  onTap: () => _pickImage(context),
                  child: Container(
                    width: width,
                    margin: const EdgeInsets.only(right: AppSizes.marginS),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.wineSurface
                          : AppColors.cocktailSurface,
                      borderRadius: BorderRadius.circular(AppSizes.radiusM),
                      border: Border.all(
                        color: isDark
                            ? AppColors.winePrimary
                            : AppColors.cocktailPrimary,
                      ),
                    ),
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      color: isDark
                          ? AppColors.winePrimary
                          : AppColors.cocktailPrimary,
                      size: AppSizes.iconL,
                    ),
                  ),
                );
              }

              return Stack(
                children: [
                  Container(
                    width: width,
                    margin: const EdgeInsets.only(right: AppSizes.marginS),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.radiusM),
                      image: DecorationImage(
                        image: FileImage(File(images[index])),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: AppSizes.paddingXS,
                    right: AppSizes.marginS + AppSizes.paddingXS,
                    child: GestureDetector(
                      onTap: () => _removeImage(index),
                      child: Container(
                        padding: const EdgeInsets.all(AppSizes.paddingXS),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(AppSizes.radiusS),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: AppSizes.iconS,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
