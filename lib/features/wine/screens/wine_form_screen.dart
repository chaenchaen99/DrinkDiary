import 'package:drink_diary/features/wine/providers/wine_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../data/models/wine.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/image_picker_widget.dart';

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
  final _nameController = TextEditingController();
  final _onelineReviewController = TextEditingController();
  final _productionYearController = TextEditingController();
  final _regionController = TextEditingController();
  final _varietyController = TextEditingController();
  final _wineryController = TextEditingController();
  final _priceController = TextEditingController();
  final _shopController = TextEditingController();
  final _alcoholContentController = TextEditingController();
  final _foodPairingController = TextEditingController();
  final _reviewController = TextEditingController();

  double _aroma = 3;
  double _body = 3;
  double _tannin = 3;
  double _acidity = 3;
  double _sweetness = 3;
  double _rating = 3;
  List<String> _images = [];
  List<String> _foodPairings = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.wine?.name ?? '';
    _onelineReviewController.text = widget.wine?.review ?? '';
    _productionYearController.text =
        widget.wine?.productionYear.toString() ?? '';
    _regionController.text = widget.wine?.region ?? '';
    _varietyController.text = widget.wine?.variety ?? '';
    _wineryController.text = widget.wine?.winery ?? '';
    _priceController.text = widget.wine?.price.toString() ?? '';
    _shopController.text = widget.wine?.shop ?? '';
    _alcoholContentController.text =
        widget.wine?.alcoholContent.toString() ?? '';
    _foodPairings =
        (widget.wine?.foodPairing as List<dynamic>?)?.cast<String>() ?? [];
    _aroma = widget.wine?.aroma.toDouble() ?? 3;
    _body = widget.wine?.body.toDouble() ?? 3;
    _tannin = widget.wine?.tannin.toDouble() ?? 3;
    _acidity = widget.wine?.acidity.toDouble() ?? 3;
    _sweetness = widget.wine?.sweetness.toDouble() ?? 3;
    _rating = widget.wine?.rating.toDouble() ?? 3;
    _images = widget.wine?.images ?? [];
    _reviewController.text = widget.wine?.review ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _productionYearController.dispose();
    _onelineReviewController.dispose();
    _regionController.dispose();
    _varietyController.dispose();
    _wineryController.dispose();
    _priceController.dispose();
    _shopController.dispose();
    _alcoholContentController.dispose();
    _foodPairingController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _images.add(image.path);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _addFoodPairing() {
    final text = _foodPairingController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _foodPairings.add(text);
        _foodPairingController.clear();
      });
    }
  }

  void _removeFoodPairing(int index) {
    setState(() {
      _foodPairings.removeAt(index);
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final wine = Wine(
        id: widget.wine?.id ?? DateTime.now().toString(),
        name: _nameController.text,
        onelineReview: _onelineReviewController.text,
        productionYear: int.parse(_productionYearController.text),
        region: _regionController.text,
        variety: _varietyController.text,
        winery: _wineryController.text,
        price: double.parse(_priceController.text),
        shop: _shopController.text,
        alcoholContent: double.parse(_alcoholContentController.text),
        aroma: _aroma.round(),
        body: _body.round(),
        tannin: _tannin.round(),
        acidity: _acidity.round(),
        sweetness: _sweetness.round(),
        rating: _rating,
        foodPairing: _foodPairings,
        images: _images,
        createdAt: widget.wine?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        review: _reviewController.text,
      );

      if (widget.wine == null) {
        ref.read(wineNotifierProvider.notifier).addWine(wine);
      } else {
        ref.read(wineNotifierProvider.notifier).updateWine(wine);
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
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
            onPressed: _submitForm,
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
                controller: _nameController,
                label: '한줄평',
                hint: '와인에 대한 한줄평을 남겨주세요',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '와인에 대한 한줄평을 남겨주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.size24),
              CustomTextField(
                controller: _foodPairingController,
                label: '음식 페어링',
                hint: '#스테이크',
                onChanged: (value) {
                  if (value.startsWith('#')) {
                    _addFoodPairing();
                  }
                },
              ),
              const SizedBox(height: AppSizes.size8),
              Wrap(
                spacing: AppSizes.size8,
                runSpacing: AppSizes.size8,
                children: _foodPairings.asMap().entries.map((entry) {
                  return Chip(
                    label: Text(entry.value),
                    onDeleted: () => _removeFoodPairing(entry.key),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSizes.size8),
              CustomTextField(
                controller: _reviewController,
                label: '리뷰',
                hint: '와인에 대한 리뷰를 남겨주세요',
              ),
              const SizedBox(height: AppSizes.size16),
              CustomTextField(
                controller: _productionYearController,
                label: '생산년도',
                hint: 'YYYY',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '생산년도를 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.size16),
              CustomTextField(
                controller: _regionController,
                label: '생산지',
                hint: '와인 생산지를 입력하세요',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '생산지를 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.size16),
              CustomTextField(
                controller: _varietyController,
                label: '품종',
                hint: '포도 품종을 입력하세요',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '품종을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.size16),
              CustomTextField(
                controller: _wineryController,
                label: '와이너리',
                hint: '와이너리 이름을 입력하세요',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '와이너리를 입력해주세요';
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
                  if (value == null || value.isEmpty) {
                    return '가격을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.size16),
              CustomTextField(
                controller: _shopController,
                label: '구매처',
                hint: '구매처를 입력하세요',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '구매처를 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.size16),
              CustomTextField(
                controller: _alcoholContentController,
                label: '알코올 도수',
                hint: '알코올 도수를 입력하세요',
                keyboardType: TextInputType.number,
                suffixText: '%',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '알코올 도수를 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.size24),
              Text(
                '와인 특성',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSizes.size16),
              _buildSlider(
                  '향', _aroma, (value) => setState(() => _aroma = value)),
              _buildSlider(
                  '바디감', _body, (value) => setState(() => _body = value)),
              _buildSlider(
                  '타닌', _tannin, (value) => setState(() => _tannin = value)),
              _buildSlider(
                  '산도', _acidity, (value) => setState(() => _acidity = value)),
              _buildSlider('단맛', _sweetness,
                  (value) => setState(() => _sweetness = value)),
              _buildSlider(
                  '추천도', _rating, (value) => setState(() => _rating = value)),
              const SizedBox(height: AppSizes.size56),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(
      String label, double value, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(value.round().toString()),
          ],
        ),
        Slider(
          value: value,
          min: 1,
          max: 5,
          divisions: 4,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
