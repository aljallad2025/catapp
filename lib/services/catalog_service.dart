import '../models/cat_item.dart';
import 'supabase_service.dart';

/// خدمة موحّدة لجلب بيانات كل الأقسام
/// تحاول أولاً الاتصال بـ Supabase (جدول items)، وإذا لم تتوفر بيانات
/// (مثلاً قبل تعبئة قاعدة البيانات) تعرض بيانات تجريبية بنفس شكل الموكاب
/// حتى لا تظهر الشاشات فارغة أثناء التطوير
class CatalogService {
  static Future<List<CatItem>> fetchItemsBySection(String section) async {
    try {
      final data = await SupabaseService.client
          .from('items')
          .select()
          .eq('section', section)
          .order('created_at', ascending: false);

      final list = (data as List)
          .map((e) => CatItem.fromMap(e as Map<String, dynamic>))
          .toList();

      if (list.isNotEmpty) return list;
    } catch (_) {
      // تجاهل الخطأ والانتقال للبيانات التجريبية (مثلاً لو الجدول غير موجود بعد)
    }
    return _sampleData(section);
  }

  static Future<CatItem?> fetchItemById(String id, String section) async {
    try {
      final data = await SupabaseService.client
          .from('items')
          .select()
          .eq('id', id)
          .maybeSingle();
      if (data != null) return CatItem.fromMap(data);
    } catch (_) {}
    return _sampleData(section).where((e) => e.id == id).firstOrNull;
  }

  static List<CatItem> _sampleData(String section) {
    switch (section) {
      case 'sale':
        return [
          CatItem(
            id: 's1',
            section: 'sale',
            title: 'Maine Coon',
            subtitle: 'العمر 4 أشهر - ذكر',
            price: 3500,
            imageUrl:
                'https://images.unsplash.com/photo-1596854307943-fb0cd66306b8?w=600',
            rating: 4.8,
            reviewsCount: 100,
            breed: 'Maine Coon',
            age: '4 أشهر',
            gender: 'ذكر',
            sellerName: 'مزرعة القطط الملكية',
            description:
                'قطة مين كون أصيلة بصحة ممتازة، مطعّمة بالكامل ومفحوصة بيطرياً.',
          ),
          CatItem(
            id: 's2',
            section: 'sale',
            title: 'British Shorthair',
            subtitle: 'العمر 3 أشهر',
            price: 2800,
            imageUrl:
                'https://images.unsplash.com/photo-1533738363-b7f9aef128ce?w=600',
            rating: 4.6,
            reviewsCount: 64,
            breed: 'British Shorthair',
          ),
          CatItem(
            id: 's3',
            section: 'sale',
            title: 'Ragdoll',
            subtitle: 'العمر 5 أشهر',
            price: 3200,
            imageUrl:
                'https://images.unsplash.com/photo-1533743983669-94fa5c4338ec?w=600',
            rating: 4.9,
            reviewsCount: 81,
            breed: 'Ragdoll',
          ),
          CatItem(
            id: 's4',
            section: 'sale',
            title: 'Scottish Fold',
            subtitle: 'العمر 2 أشهر',
            price: 2500,
            imageUrl:
                'https://images.unsplash.com/photo-1519052537078-e6302a4968d4?w=600',
            rating: 4.7,
            reviewsCount: 45,
            breed: 'Scottish Fold',
          ),
        ];
      case 'mating':
        return [
          CatItem(
            id: 'm1',
            section: 'mating',
            title: 'طلب تزاوج - Persian',
            subtitle: 'ذكر أصيل متاح للتزاوج',
            price: 150,
            imageUrl:
                'https://images.unsplash.com/photo-1592194996308-7b43878e84a6?w=600',
            rating: 4.5,
            breed: 'Persian',
          ),
        ];
      case 'adoption':
        return [
          CatItem(
            id: 'a1',
            section: 'adoption',
            title: 'قطة للتبني - بلدي',
            subtitle: 'بحاجة لعائلة محبة',
            price: 0,
            imageUrl:
                'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=600',
            rating: 5.0,
          ),
        ];
      case 'food':
        return [
          CatItem(
            id: 'f1',
            section: 'food',
            title: 'طعام جاف - Royal Canin',
            subtitle: '2 كجم - لجميع الأعمار',
            price: 18,
            imageUrl:
                'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=600',
            rating: 4.7,
            reviewsCount: 210,
          ),
        ];
      case 'accessories':
        return [
          CatItem(
            id: 'ac1',
            section: 'accessories',
            title: 'برج خدش وألعاب',
            subtitle: 'خشب طبيعي - متعدد الطوابق',
            price: 45,
            imageUrl:
                'https://images.unsplash.com/photo-1545249390-6bdfa286032f?w=600',
            rating: 4.6,
          ),
        ];
      case 'hotel':
        return [
          CatItem(
            id: 'h1',
            section: 'hotel',
            title: 'غرفة فندقة فاخرة',
            subtitle: 'إقامة يومية مع رعاية كاملة',
            price: 45,
            imageUrl:
                'https://images.unsplash.com/photo-1596492784531-6e6eb5ea9993?w=600',
            rating: 4.9,
          ),
        ];
      case 'vet':
        return [
          CatItem(
            id: 'v1',
            section: 'vet',
            title: 'استشارة بيطرية عامة',
            subtitle: 'فحص شامل + تطعيمات',
            price: 20,
            imageUrl:
                'https://images.unsplash.com/photo-1628009368231-7bb7cfcb0def?w=600',
            rating: 4.8,
          ),
        ];
      default:
        return [];
    }
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
