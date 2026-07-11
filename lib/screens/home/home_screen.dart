import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/section_card.dart';
import '../../widgets/cat_house_logo.dart';
import '../../widgets/home_promo_banner.dart';
import '../section/section_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Map<AppSection, IconData> _icons = {
    AppSection.sale: Icons.shopping_cart_outlined,
    AppSection.mating: Icons.favorite_outline,
    AppSection.adoption: Icons.home_outlined,
    AppSection.food: Icons.set_meal_outlined,
    AppSection.accessories: Icons.checkroom_outlined,
    AppSection.hotel: Icons.hotel_outlined,
    AppSection.vet: Icons.medical_services_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  children: [
                    const CatHouseLogo(size: 52, showText: false),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('The Cat House',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontSize: 18)),
                          const Text(
                            'كل ما يحتاجه قطك في مكان واحد',
                            style: TextStyle(
                                color: AppColors.textGrey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none_rounded,
                          color: AppColors.textDark),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'ابحث عن قطط أو خدمات...',
                      prefixIcon: Icon(Icons.search, color: AppColors.textGrey),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: HomePromoBanner(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              sliver: SliverToBoxAdapter(
                child: Text('الأقسام الرئيسية للتطبيق',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.92,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final section = AppSection.values[index];
                    return SectionCard(
                      section: section,
                      icon: _icons[section]!,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                SectionListScreen(section: section),
                          ),
                        );
                      },
                    );
                  },
                  childCount: AppSection.values.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.05,
                  children: const [
                    _TrustBadge(
                        icon: Icons.verified_user_outlined,
                        label: 'منصة موثوقة'),
                    _TrustBadge(
                        icon: Icons.emoji_events_outlined,
                        label: 'تجربة سهلة وآمنة'),
                    _TrustBadge(
                        icon: Icons.headset_mic_outlined,
                        label: 'دعم فني مميز'),
                    _TrustBadge(
                        icon: Icons.local_shipping_outlined,
                        label: 'خدمات متكاملة'),
                    _TrustBadge(
                        icon: Icons.lock_outline_rounded,
                        label: 'طرق دفع آمنة'),
                    _TrustBadge(
                        icon: Icons.card_giftcard_outlined,
                        label: 'عروض وخصومات'),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _TrustBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TrustBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
