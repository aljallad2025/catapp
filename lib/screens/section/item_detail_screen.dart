import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../models/cat_item.dart';
import '../booking/booking_screen.dart';

class ItemDetailScreen extends StatelessWidget {
  final CatItem item;
  final AppSection section;

  const ItemDetailScreen(
      {super.key, required this.item, required this.section});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: section.color,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: item.imageUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  color: AppColors.border,
                  child: const Icon(Icons.pets, size: 48),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(item.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium),
                      ),
                      Text(
                        item.price == 0
                            ? 'مجاناً'
                            : '${item.price.toStringAsFixed(0)} ${item.currency}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(item.subtitle,
                      style: const TextStyle(color: AppColors.textGrey)),
                  const SizedBox(height: 12),
                  if (item.rating > 0)
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: Color(0xFFF5A623), size: 20),
                        const SizedBox(width: 4),
                        Text('${item.rating}',
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(width: 4),
                        Text('(${item.reviewsCount} تقييم)',
                            style:
                                const TextStyle(color: AppColors.textGrey)),
                      ],
                    ),
                  const SizedBox(height: 20),
                  if (item.breed != null || item.age != null || item.gender != null)
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        if (item.breed != null)
                          _InfoChip(label: 'السلالة', value: item.breed!),
                        if (item.age != null)
                          _InfoChip(label: 'العمر', value: item.age!),
                        if (item.gender != null)
                          _InfoChip(label: 'الجنس', value: item.gender!),
                      ],
                    ),
                  const SizedBox(height: 20),
                  Text('الوصف',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(
                    item.description.isEmpty
                        ? 'لا يوجد وصف تفصيلي متاح حالياً.'
                        : item.description,
                    style: const TextStyle(
                        color: AppColors.textGrey, height: 1.6),
                  ),
                  if (item.sellerName.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                AppColors.primary.withOpacity(0.12),
                            child: const Icon(Icons.storefront_outlined,
                                color: AppColors.primary),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('البائع/مقدم الخدمة',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textGrey)),
                                Text(item.sellerName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: section.color),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      BookingScreen(item: item, section: section),
                ),
              );
            },
            child: Text(_ctaLabel(section)),
          ),
        ),
      ),
    );
  }

  String _ctaLabel(AppSection section) {
    switch (section) {
      case AppSection.sale:
        return 'شراء الآن';
      case AppSection.mating:
        return 'طلب تزاوج';
      case AppSection.adoption:
        return 'طلب تبني';
      case AppSection.food:
      case AppSection.accessories:
        return 'أضف إلى السلة';
      case AppSection.hotel:
        return 'احجز الآن';
      case AppSection.vet:
        return 'احجز موعد';
    }
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;

  const _InfoChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.border.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text('$label: $value',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}
