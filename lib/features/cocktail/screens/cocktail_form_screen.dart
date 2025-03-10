import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../data/models/cocktail.dart';
import '../../../shared/widgets/rating_bar.dart';
import '../../../shared/widgets/image_picker_widget.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/tag_input.dart';
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
  late final TextEditingController _glassController;
  late final TextEditingController _garnishController;
  late final TextEditingController _priceController;
  late final TextEditingController _noteController;
  final List<TextEditingController> _ingredientControllers = [];
  final List<TextEditingController> _recipeControllers = [];
  double _rating = 0;
  List<String> _tags = [];
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.cocktail?.name);
    _baseController = TextEditingController(text: widget.cocktail?.base);
    _glassController = TextEditingController(text: widget.cocktail?.glass);
    _garnishController = TextEditingController(text: widget.cocktail?.garnish);
    _priceController = TextEditingController(
      text: widget.cocktail?.price.toString(),
    );
    _noteController = TextEditingController(text: widget.cocktail?.note);
    _rating = widget.cocktail?.rating ?? 0;
    _tags = widget.cocktail?.tags ?? [];
    _images = widget.cocktail?.images?.cast<String>() ?? [];

    if (widget.cocktail != null) {
      if (widget.cocktail!.ingredients != null) {
        for (final ingredient in widget.cocktail!.ingredients!) {
          _ingredientControllers.add(TextEditingController(text: ingredient));
        }
      }
      if (widget.cocktail!.recipe != null) {
        for (final step in widget.cocktail!.recipe!) {
          _recipeControllers.add(TextEditingController(text: step));
        }
      }
    }

    if (_ingredientControllers.isEmpty) {
      _addIngredient();
    }
    if (_recipeControllers.isEmpty) {
      _addRecipeStep();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _baseController.dispose();
    _glassController.dispose();
    _garnishController.dispose();
    _priceController.dispose();
    _noteController.dispose();
    for (final controller in _ingredientControllers) {
      controller.dispose();
    }
    for (final controller in _recipeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addIngredient() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredientControllers[index].dispose();
      _ingredientControllers.removeAt(index);
    });
  }

  void _addRecipeStep() {
    setState(() {
      _recipeControllers.add(TextEditingController());
    });
  }

  void _removeRecipeStep(int index) {
    setState(() {
      _recipeControllers[index].dispose();
      _recipeControllers.removeAt(index);
    });
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final cocktail = Cocktail(
        id: widget.cocktail?.id ?? DateTime.now().toString(),
        name: _nameController.text,
        base: _baseController.text,
        glass: _glassController.text,
        garnish: _garnishController.text,
        price: double.parse(_priceController.text),
        rating: _rating,
        ingredients: _ingredientControllers
            .map((controller) => controller.text)
            .where((text) => text.isNotEmpty)
            .toList(),
        recipe: _recipeControllers
            .map((controller) => controller.text)
            .where((text) => text.isNotEmpty)
            .toList(),
        note: _noteController.text,
        tags: _tags,
        images: _images,
        createdAt: widget.cocktail?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (widget.cocktail == null) {
        ref.read(cocktailNotifierProvider.notifier).addCocktail(cocktail);
      } else {
        ref.read(cocktailNotifierProvider.notifier).updateCocktail(cocktail);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cocktail == null ? '칵테일 추가' : '칵테일 수정'),
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
                label: '칵테일 이름',
                hint: '칵테일 이름을 입력하세요',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '칵테일 이름을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.size16),
              CustomTextField(
                controller: _baseController,
                label: '베이스',
                hint: '베이스를 입력하세요',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '베이스를 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.size16),
              CustomTextField(
                controller: _glassController,
                label: '글래스',
                hint: '글래스를 입력하세요',
              ),
              const SizedBox(height: AppSizes.size16),
              CustomTextField(
                controller: _garnishController,
                label: '가니쉬',
                hint: '가니쉬를 입력하세요',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '재료',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addIngredient,
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.size8),
              ..._ingredientControllers.asMap().entries.map((entry) {
                final index = entry.key;
                final controller = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.size8),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: controller,
                          label: '재료',
                          hint: '재료를 입력하세요',
                          validator: (value) {
                            if (index == 0 &&
                                (value == null || value.isEmpty)) {
                              return '최소 하나의 재료를 입력해주세요';
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_ingredientControllers.length > 1)
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => _removeIngredient(index),
                        ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: AppSizes.size24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '레시피',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addRecipeStep,
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.size8),
              ..._recipeControllers.asMap().entries.map((entry) {
                final index = entry.key;
                final controller = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.size8),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: controller,
                          label: '레시피 단계',
                          hint: '레시피 단계를 입력하세요',
                          validator: (value) {
                            if (index == 0 &&
                                (value == null || value.isEmpty)) {
                              return '최소 하나의 레시피 단계를 입력해주세요';
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_recipeControllers.length > 1)
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => _removeRecipeStep(index),
                        ),
                    ],
                  ),
                );
              }),
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
