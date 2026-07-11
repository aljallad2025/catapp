import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/cat_item.dart';
import '../../services/catalog_service.dart';
import '../../widgets/item_card.dart';
import 'item_detail_screen.dart';

class SectionListScreen extends StatefulWidget {
  final AppSection section;

  const SectionListScreen({super.key, required this.section});

  @override
  State<SectionListScreen> createState() => _SectionListScreenState();
}

class _SectionListScreenState extends State<SectionListScreen> {
  late Future<List<CatItem>> _future;

  String get _sectionKey {
    switch (widget.section) {
      case AppSection.sale:
        return 'sale';
      case AppSection.mating:
        return 'mating';
      case AppSection.adoption:
        return 'adoption';
      case AppSection.food:
        return 'food';
      case AppSection.accessories:
        return 'accessories';
      case AppSection.hotel:
        return 'hotel';
      case AppSection.vet:
        return 'vet';
    }
  }

  @override
  void initState() {
    super.initState();
    _future = CatalogService.fetchItemsBySection(_sectionKey);
  }

  @override
  Widget build(BuildContext context) {
    final section = widget.section;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(section.title),
        backgroundColor: section.color,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: section.color,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              section.subtitle,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<CatItem>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final items = snapshot.data ?? [];
                if (items.isEmpty) {
                  return const Center(child: Text('لا توجد عناصر بعد'));
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ItemCard(
                      item: item,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ItemDetailScreen(
                              item: item,
                              section: section,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
