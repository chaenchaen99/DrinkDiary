import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../data/models/comment.dart';
import '../../../data/models/drinkbar.dart';
import 'components/bar_image_gallery.dart';

class BarDetailsView extends StatelessWidget {
  final DrinkBar bar;

  const BarDetailsView({super.key, required this.bar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarHeaderInfo(
            name: bar.name,
            address: bar.address,
          ),
          if (bar.phone != null) BarContactInfo(phone: bar.phone!),
          const SizedBox(height: AppSizes.paddingS),
          BarImageGallery(images: bar.images),
          const SizedBox(height: AppSizes.paddingM),
          BarDescription(
            onelineReview: bar.onelineReview,
            description: bar.description,
          ),
          const SizedBox(height: AppSizes.paddingL),
          CommentsSection(comments: bar.comments),
        ],
      ),
    );
  }
}

class BarHeaderInfo extends StatelessWidget {
  final String name;
  final String address;

  const BarHeaderInfo({
    super.key,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSizes.paddingS),
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.grey, size: 14),
            const SizedBox(width: AppSizes.paddingXS),
            Text(
              address,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BarContactInfo extends StatelessWidget {
  final String phone;

  const BarContactInfo({
    super.key,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.paddingXS),
      child: Row(
        children: [
          const Icon(Icons.phone, color: Colors.grey, size: 14),
          const SizedBox(width: AppSizes.paddingXS),
          Text(
            phone,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class BarDescription extends StatelessWidget {
  final String onelineReview;
  final String? description;

  const BarDescription({
    super.key,
    required this.onelineReview,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.recommend, color: Colors.grey, size: 14),
            const SizedBox(width: AppSizes.paddingXS),
            Expanded(
              child: Text(
                onelineReview,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
        if (description != null) ...[
          const SizedBox(height: AppSizes.paddingXS),
          Text(
            description!,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ],
    );
  }
}

class CommentsSection extends StatelessWidget {
  final List<Comment> comments;

  const CommentsSection({
    super.key,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(),
        ...comments.map((comment) => _buildCommentItem(comment)),
      ],
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: Colors.grey[200], height: 1),
        const SizedBox(height: AppSizes.paddingS),
        const Text(
          '답글',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSizes.paddingS),
        Divider(color: Colors.grey[200], height: 1),
      ],
    );
  }

  Widget _buildCommentItem(Comment comment) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(comment.userId),
              ),
              const SizedBox(width: AppSizes.paddingS),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.userId,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      comment.text,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[850],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey[200], height: 1),
      ],
    );
  }
}
