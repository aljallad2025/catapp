/// نموذج موحّد يمثل أي عنصر يُعرض داخل أي قسم من الأقسام السبعة
/// (قطة للبيع، طلب تزاوج، قطة للتبني، منتج طعام، إكسسوار، غرفة فندقة، خدمة بيطرية)
class CatItem {
  final String id;
  final String section; // sale | mating | adoption | food | accessories | hotel | vet
  final String title;
  final String subtitle;
  final double price;
  final String currency;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final String? breed;
  final String? age;
  final String? gender;
  final String description;
  final String sellerName;
  final String? sellerPhone;
  final DateTime createdAt;

  CatItem({
    required this.id,
    required this.section,
    required this.title,
    required this.subtitle,
    required this.price,
    this.currency = 'ر.ع',
    required this.imageUrl,
    this.rating = 0,
    this.reviewsCount = 0,
    this.breed,
    this.age,
    this.gender,
    this.description = '',
    this.sellerName = '',
    this.sellerPhone,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory CatItem.fromMap(Map<String, dynamic> map) {
    return CatItem(
      id: map['id'].toString(),
      section: map['section'] ?? '',
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0,
      currency: map['currency'] ?? 'ر.ع',
      imageUrl: map['image_url'] ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0,
      reviewsCount: map['reviews_count'] ?? 0,
      breed: map['breed'],
      age: map['age'],
      gender: map['gender'],
      description: map['description'] ?? '',
      sellerName: map['seller_name'] ?? '',
      sellerPhone: map['seller_phone'],
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'section': section,
      'title': title,
      'subtitle': subtitle,
      'price': price,
      'currency': currency,
      'image_url': imageUrl,
      'rating': rating,
      'reviews_count': reviewsCount,
      'breed': breed,
      'age': age,
      'gender': gender,
      'description': description,
      'seller_name': sellerName,
      'seller_phone': sellerPhone,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
