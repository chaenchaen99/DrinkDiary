import 'package:drink_diary/features/wine/providers/wine_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../data/models/wine.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/rating_bar.dart';
import '../../../shared/widgets/image_picker_widget.dart';
import '../../../shared/widgets/tag_input.dart';

class WineFormScreen extends ConsumerStatefulWidget {
  final Wine? wine;

  const WineFormScreen({
    super.key,
    this.wine,
  });

  @override
  ConsumerState<WineFormScreen> createState() => _WineFormScreenState();
}

class _WineFormScreenState extends ConsumerState<WineFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _varietyController;
  late final TextEditingController _regionController;
  late final TextEditingController _vintageController;
  late final TextEditingController _priceController;
  late final TextEditingController _noteController;
  double _rating = 0;
  List<String> _tags = [];
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.wine?.name);
    _varietyController = TextEditingController(text: widget.wine?.variety);
    _regionController = TextEditingController(text: widget.wine?.region);
    _vintageController = TextEditingController(
      text: widget.wine?.productionYear.toString(),
    );
    _priceController = TextEditingController(
      text: widget.wine?.price.toString(),
    );
    _noteController = TextEditingController(text: widget.wine?.review);
    _rating = widget.wine?.rating ?? 0;
    _tags = widget.wine?.tags ?? [];
    _images = widget.wine?.images ?? [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _varietyController.dispose();
    _regionController.dispose();
    _vintageController.dispose();
    _priceController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final wine = Wine(
        id: widget.wine?.id ?? DateTime.now().toString(),
        name: _nameController.text,
        variety: _varietyController.text,
        region: _regionController.text,
        productionYear: int.parse(_vintageController.text),
        price: double.parse(_priceController.text),
        rating: _rating,
        review: _noteController.text,
        tags: _tags,
        images: _images,
        createdAt: widget.wine?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        winery: '',
        shop: '',
        alcoholContent: 0.0,
        aroma: 0,
        body: 0,
        tannin: 0,
        acidity: 0,
      );

      if (widget.wine == null) {
        ref.read(wineNotifierProvider.notifier).addWine(wine);
      } else {
        ref.read(wineNotifierProvider.notifier).updateWine(wine);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wine == null ? '와인 추가' : '와인 수정'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _onSubmit,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.size16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImagePickerWidget(
                images: _images,
                onImagesChanged: (images) {
                  setState(() {
                    _images = images;
                  });
                },
              ),
              const SizedBox(height: AppSizes.size24),
              CustomTextField(
                controller: _nameController,
                label: '와인 이름',
                hint: '와인 이름을 입력하세요',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '와인 이름을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.size16),
              CustomTextField(
                controller: _varietyController,
                label: '품종',
                hint: '품종을 입력하세요',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '품종을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.size16),
              CustomTextField(
                controller: _regionController,
                label: '생산지',
                hint: '생산지를 입력하세요',
              ),
              const SizedBox(height: AppSizes.size16),
              CustomTextField(
                controller: _vintageController,
                label: '빈티지',
                hint: '빈티지를 입력하세요',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final number = int.tryParse(value);
                    if (number == null) {
                      return '올바른 숫자를 입력해주세요';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.size16),
              CustomTextField(
                controller: _priceController,
                label: '가격',
                hint: '가격을 입력하세요',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final number = double.tryParse(value);
                    if (number == null) {
                      return '올바른 숫자를 입력해주세요';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.size24),
              Text(
                '평가',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSizes.size8),
              RatingBar(
                rating: _rating,
                size: AppSizes.size32,
                onChanged: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              const SizedBox(height: AppSizes.size24),
              TagInput(
                label: '태그',
                hint: '태그를 입력하세요',
                tags: _tags,
                onTagsChanged: (tags) {
                  setState(() {
                    _tags = tags;
                  });
                },
              ),
              const SizedBox(height: AppSizes.size24),
              CustomTextField(
                controller: _noteController,
                label: '메모',
                hint: '메모를 입력하세요',
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
