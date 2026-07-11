import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

/// البانر الترويجي بأعلى الصفحة الرئيسية - نفس محتوى الموكاب الأصلي
/// (صورة قطة + قائمة مميزات التطبيق بعلامات صح)
class HomePromoBanner extends StatelessWidget {
  const HomePromoBanner({super.key});

  static const List<String> _features = [
    'بيع وشراء القطط',
    'التزاوج بأمان وموثوقية',
    'التبني ومنح حياة جديدة',
    'أنظمة صحية ومغذية للقطط',
    'إكسسوارات ولوازم متكاملة',
    'فندقة راقية ومريحة',
    'استشارات وعلاج بيطري',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'كل ما يحتاجه قطك\nفي مكان واحد',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 16, height: 1.3),
                  ),
                  const SizedBox(height: 10),
                  ..._features.map(
                    (f) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle_rounded,
                              color: AppColors.success, size: 15),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              f,
                              style: const TextStyle(
                                fontSize: 11.5,
                                color: AppColors.textDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: CachedNetworkImage(
              imageUrl:
                  'https://images.unsplash.com/photo-1533738363-b7f9aef128ce?w=500',
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(color: AppColors.border),
              errorWidget: (context, url, error) => Container(
                color: AppColors.border,
                child: const Icon(Icons.pets, color: AppColors.textGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
