import 'dart:io';

import 'package:flutter/material.dart';
import 'package:drink_diary/core/constants/app_sizes.dart';
import 'package:drink_diary/data/models/drinkbar.dart';
import 'package:drink_diary/shared/widgets/form_section.dart';
import 'package:drink_diary/shared/widgets/image_picker_widget.dart';

import '../../../shared/widgets/custom_text_field.dart';

class BarFormScreen extends StatefulWidget {
  final DrinkBar? bar; // 수정 시 사용

  const BarFormScreen({super.key, this.bar});

  @override
  State<BarFormScreen> createState() => _BarFormScreenState();
}

class _BarFormScreenState extends State<BarFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _onelineReviewController;
  late final TextEditingController _phoneController;
  late final TextEditingController _linkController;
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.bar?.name);
    _addressController = TextEditingController(text: widget.bar?.address);
    _descriptionController =
        TextEditingController(text: widget.bar?.description);
    _onelineReviewController =
        TextEditingController(text: widget.bar?.onelineReview);
    _phoneController = TextEditingController(text: widget.bar?.phone);
    _linkController = TextEditingController(text: widget.bar?.link);
    _images = widget.bar?.images?.toList() ?? [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _onelineReviewController.dispose();
    _phoneController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bar == null ? '펍/바 추가' : '펍/바 수정'),
        actions: [
          TextButton(
            onPressed: _handleSubmit,
            child: const Text(
              '완료',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: AppSizes.paddingL),

            // 이미지 선택 섹션
            FormSection(
              title: '사진',
              children: [
                ImagePickerWidget(
                  images: _images,
                  onImagesChanged: (images) {
                    setState(() {
                      _images = images;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: AppSizes.paddingL),

            // 기본 정보 섹션
            FormSection(
              title: '기본 정보',
              children: [
                CustomTextField(
                  controller: _nameController,
                  label: '바 이름',
                ),
                CustomTextField(
                  controller: _addressController,
                  label: '주소',
                ),
                CustomTextField(
                  controller: _phoneController,
                  label: '전화번호',
                  keyboardType: TextInputType.phone,
                ),
                CustomTextField(
                  controller: _linkController,
                  label: '웹사이트/SNS 링크',
                  keyboardType: TextInputType.url,
                ),
              ],
            ),

            const SizedBox(height: AppSizes.paddingL),

            // 상세 정보 섹션
            FormSection(
              title: '나의 추천',
              children: [
                CustomTextField(
                  controller: _onelineReviewController,
                  label: '한 줄 리뷰',
                ),
                CustomTextField(
                  controller: _descriptionController,
                  label: '상세 설명',
                  maxLines: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final bar = DrinkBar(
        id: widget.bar?.id ?? DateTime.now().toString(),
        name: _nameController.text,
        address: _addressController.text,
        latitude: widget.bar?.latitude ?? 0,
        longitude: widget.bar?.longitude ?? 0,
        description: _descriptionController.text,
        onelineReview: _onelineReviewController.text,
        images: _images,
        phone: _phoneController.text,
        link: _linkController.text,
        createdAt: widget.bar?.createdAt ?? DateTime.now(),
        createdBy: widget.bar?.createdBy ?? 'user',
      );

      Navigator.pop(context, bar);
    }
  }
}
