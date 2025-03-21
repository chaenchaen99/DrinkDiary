import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/constants/app_strings.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';

class ImagePickerWidget extends StatefulWidget {
  final List<String> images;
  final Function(List<String>) onImagesChanged;
  final double height;
  final double width;

  const ImagePickerWidget({
    super.key,
    required this.images,
    required this.onImagesChanged,
    this.height = AppSizes.imagePreview,
    this.width = AppSizes.imagePreview,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  @override
  void initState() {
    super.initState();
    _requestGalleryPermission();
  }

  Future<void> _pickImage(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      // 여러 이미지 선택
      final List<XFile> images = await picker.pickMultiImage(
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (images.isNotEmpty) {
        // 여러 이미지가 선택되었을 경우, 기존 이미지 리스트에 추가
        final savedPaths = await saveImagesToLocal(images);
        final updatedImages = List<String>.from(widget.images)
          ..addAll(savedPaths);
        widget.onImagesChanged(updatedImages);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<List<String>> saveImagesToLocal(List<XFile> pickedFiles) async {
    List<String> savedPaths = [];

    // 플랫폼별 저장 경로 설정
    Directory? directory;

    if (Platform.isAndroid) {
      // Android는 외부 저장소(Pictures) 사용
      directory = Directory('/storage/emulated/0/Pictures');
    } else if (Platform.isIOS) {
      // iOS는 앱의 Document 디렉토리 사용
      directory = await getApplicationDocumentsDirectory();
    }

    if (directory == null) {
      debugPrint('저장할 디렉토리를 찾을 수 없음');
      return [];
    }

    for (var pickedFile in pickedFiles) {
      debugPrint('디렉토리만: $directory');
      final String newPath =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}_${pickedFile.name}';

      try {
        final File newImage = await File(pickedFile.path).copy(newPath);

        if (await newImage.exists()) {
          debugPrint('이미지 저장 완료: $newPath');
          savedPaths.add(newImage.path);
        } else {
          debugPrint('이미지 저장 실패: $newPath');
        }
      } catch (e) {
        debugPrint('이미지 저장 중 오류 발생: $e');
      }
    }

    return savedPaths;
  }

  void _removeImage(int index) {
    final newImages = List<String>.from(widget.images);
    newImages.removeAt(index);
    widget.onImagesChanged(newImages);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset('assets/icons/check.png', width: 16, height: 16),
            const SizedBox(width: AppSizes.paddingXS),
            Text(
              AppStrings.photo,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: AppSizes.paddingXS),
        SizedBox(
          height: widget.height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                  onTap: () => _pickImage(context),
                  child: Container(
                    width: widget.width,
                    margin: const EdgeInsets.only(right: AppSizes.marginS),
                    decoration: BoxDecoration(
                      color:
                          isDark ? AppColors.secondary : AppColors.onSecondary,
                      borderRadius: BorderRadius.circular(AppSizes.radius12),
                      border: Border.all(
                        color: isDark
                            ? AppColors.winePrimary
                            : AppColors.onPrimary,
                      ),
                    ),
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      color:
                          isDark ? AppColors.winePrimary : AppColors.onPrimary,
                      size: AppSizes.iconL,
                    ),
                  ),
                );
              }

              return Stack(
                children: [
                  Container(
                    width: widget.width,
                    margin: const EdgeInsets.only(right: AppSizes.marginS),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.radius12),
                      image: DecorationImage(
                        image: FileImage(File(widget.images[index - 1])),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: AppSizes.paddingXS,
                    right: AppSizes.marginS + AppSizes.paddingXS,
                    child: GestureDetector(
                      onTap: () => _removeImage(index - 1),
                      child: Container(
                        padding: const EdgeInsets.all(AppSizes.paddingXS),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(AppSizes.radius8),
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

  // 갤러리 권한 요청
  Future<void> _requestGalleryPermission() async {
    // 갤러리 권한 상태 확인
    PermissionStatus status = await Permission.photos.status;

    if (status.isDenied) {
      // 권한이 거부된 경우 요청
      await Permission.photos.request();
    }

    if (status.isPermanentlyDenied) {
      // 영구적으로 거부된 경우 설정 화면으로 안내
      _showPermissionDialog();
    } else if (status.isGranted) {
      // 권한이 허용된 경우 (추가로 필요한 작업을 여기서 처리)
      print("갤러리 접근 권한이 허용되었습니다.");
    }
  }

  // 권한이 영구적으로 거부된 경우 설정 화면으로 안내하는 다이얼로그 표시
  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('권한 요청'),
          content: const Text('앱이 사진첩을 사용하려면 권한이 필요합니다. 설정에서 권한을 변경해주세요.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                openAppSettings(); // 설정 화면으로 이동
                Navigator.of(context).pop();
              },
              child: const Text('설정으로 이동'),
            ),
          ],
        );
      },
    );
  }
}
