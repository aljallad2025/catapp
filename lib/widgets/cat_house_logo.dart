import 'package:flutter/material.dart';

/// شعار "The Cat House Oman" - الملف الأصلي حرفياً كما أرسله ثائر
class CatHouseLogo extends StatelessWidget {
  final double size;
  final bool showText; // موجود للتوافق مع الاستدعاءات القديمة (بدون تأثير الآن)

  const CatHouseLogo({
    super.key,
    this.size = 160,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo_original.jpg',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
