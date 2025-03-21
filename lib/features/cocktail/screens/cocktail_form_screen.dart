import 'package:drink_diary/features/cocktail/cocktail_validator.dart';
import 'package:drink_diary/shared/widgets/form_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../data/models/cocktail.dart';
import '../../../shared/widgets/rating_bar.dart';
import '../../../shared/widgets/image_picker_widget.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../home/providers/category_provider.dart';
import '../providers/cocktail_provider.dart';

class CocktailFormScreen extends ConsumerStatefulWidget {
  final Cocktail? cocktail;

  const CocktailFormScreen({
    super.key,
    this.cocktail,
  });

  @override
  ConsumerState<CocktailFormScreen> createState() => _CocktailFormScreenState();
}

class _CocktailFormScreenState extends ConsumerState<CocktailFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _baseController;
  late final TextEditingController _reviewController;
  late final TextEditingController _ingredientControllers;
  late final TextEditingController _recipeControllers;
  late final TextEditingController _onelineReviewControllers;
  late final TextEditingController _tasteTagController;
  double _rating = 3;
  List<String> _tasteTags = [];
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.cocktail?.name);
    _baseController = TextEditingController(text: widget.cocktail?.base);
    _reviewController = TextEditingController(text: widget.cocktail?.review);
    _ingredientControllers =
        TextEditingController(text: widget.cocktail?.ingredients);
    _recipeControllers = TextEditingController(text: widget.cocktail?.recipe);
    _onelineReviewControllers =
        TextEditingController(text: widget.cocktail?.onelineReview);
    _rating = widget.cocktail?.rating ?? 3;
    _tasteTagController = TextEditingController();
    _tasteTags =
        List<String>.from((widget.cocktail?.tags as List<dynamic>?) ?? []);
    _images = widget.cocktail?.images?.cast<String>() ?? [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _baseController.dispose();
    _reviewController.dispose();
    _ingredientControllers.dispose();
    _recipeControllers.dispose();
    _tasteTagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoryNotifierProvider);

    return Scaffold(
      appBar: FormAppBar(
        onSubmit: _onSubmit,
        drinkName: category.isCocktail ? '칵테일' : '와인',
        category: category,
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
              const SizedBox(height: AppSizes.size8),
              CustomTextField(
                controller: _nameController,
                label: '칵테일 이름',
                hint: '칵테일 이름을 입력하세요',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '칵테일 이름을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.size8),
              CustomTextField(
                controller: _onelineReviewControllers,
                label: '한줄평',
                hint: '한줄평을 입력해주세요',
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '한줄평을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.size8),
              CustomTextField(
                controller: _baseController,
                label: '베이스',
                hint: '베이스를 입력해주세요',
              ),
              const SizedBox(height: AppSizes.size8),
              CustomTextField(
                controller: _ingredientControllers,
                label: '재료',
                hint: '재료를 입력해주세요',
              ),
              const SizedBox(height: AppSizes.size8),
              CustomTextField(
                controller: _recipeControllers,
                label: '레시피',
                hint: '레시피를 입력해주세요',
              ),
              const SizedBox(height: AppSizes.size8),
              CustomTextField(
                controller: _tasteTagController,
                label: '맛 태그',
                hint: '#달콤, #과일향, #신맛',
                onChanged: (value) {
                  if (value.endsWith(',')) {
                    _addTasteTag();
                  }
                },
              ),
              Wrap(
                spacing: AppSizes.size8,
                runSpacing: AppSizes.size8,
                children: _tasteTags.asMap().entries.map((entry) {
                  return Chip(
                    label: Text(entry.value),
                    onDeleted: () => _removeTasteTag(entry.key),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSizes.size8),
              RatingBar(
                rating: _rating,
                label: '추천도',
                activeColor: category.theme.backgroundColor,
                inactiveColor: category.theme.backgroundColor,
                onChanged: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              const SizedBox(height: AppSizes.size8),
              CustomTextField(
                controller: _reviewController,
                label: '기록',
                icon: 'assets/icons/memo.png',
                hint: '칵테일과 함께했던 몽글몽글한 시간을 나눠주세요',
                maxLines: 5,
              ),
              const SizedBox(height: AppSizes.size56),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      final cocktail = Cocktail(
        id: widget.cocktail?.id ?? DateTime.now().toString(),
        name: _nameController.text,
        base: _baseController.text,
        rating: _rating,
        ingredients: _ingredientControllers.text,
        recipe: _recipeControllers.text,
        review: _reviewController.text,
        tags: _tasteTags,
        images: _images,
        createdAt: widget.cocktail?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        onelineReview: _onelineReviewControllers.text,
      );

      String message = '';
      bool isUpdated = false;

      if (widget.cocktail == null) {
        await ref.read(cocktailNotifierProvider.notifier).addCocktail(cocktail);
        message = '칵테일 기록이 생성되었습니다.';
        isUpdated = true;
      } else {
        if (CocktailValidator.isCocktailChanged(widget.cocktail!, cocktail)) {
          await ref
              .read(cocktailNotifierProvider.notifier)
              .updateCocktail(cocktail);
          message = '칵테일 기록이 수정되었습니다.';
          isUpdated = true;
        } else {
          message = '수정된 내용이 없습니다.';
          isUpdated = false;
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        if (isUpdated) {
          Navigator.of(context).pop();
        }
      }
    }
  }

  void _addTasteTag() {
    final text = _tasteTagController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _tasteTags.add(text.replaceAll('#', '').replaceAll(',', ''));
        _tasteTagController.clear();
      });
    }
  }

  void _removeTasteTag(int index) {
    setState(() {
      _tasteTags.removeAt(index);
    });
  }
}
