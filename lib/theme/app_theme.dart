import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// نظام الألوان والهوية البصرية لتطبيق The Cat House Oman
/// الألوان مأخوذة من الشعار الرسمي: دائرة حمراء مرجانية + أبيض
class AppColors {
  AppColors._();

  // اللون الأساسي من الشعار (الأحمر المرجاني)
  static const Color primary = Color(0xFFEA5A5A);
  static const Color primaryDark = Color(0xFFD14848);
  static const Color primaryLight = Color(0xFFFF8080);

  // ألوان محايدة
  static const Color background = Color(0xFFFFFBF8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF2B2422);
  static const Color textGrey = Color(0xFF8A7F7C);
  static const Color border = Color(0xFFF0E4E0);

  // ألوان الأقسام السبعة (من الموكاب)
  static const Color sectionSale = Color(0xFF6C4FD6); // البيع - بنفسجي
  static const Color sectionMating = Color(0xFFE0559A); // التزاوج - وردي
  static const Color sectionAdoption = Color(0xFF3AA65B); // التبني - أخضر
  static const Color sectionFood = Color(0xFFE8912B); // الأطعمة - برتقالي
  static const Color sectionAccessories = Color(0xFF3E7BC4); // الإكسسوارات - أزرق
  static const Color sectionHotel = Color(0xFF17A398); // الفندقة - فيروزي
  static const Color sectionVet = Color(0xFFD84343); // البيطرة - أحمر

  // حالات
  static const Color success = Color(0xFF2FA84F);
  static const Color warning = Color(0xFFE8A93B);
  static const Color error = Color(0xFFD64545);
}

class AppTheme {
  AppTheme._();

  // خط عربي أساسي لكل نصوص الواجهة
  static TextStyle get _baseArabicFont => GoogleFonts.cairo();

  // خط بلعبة/دائري للعناوين الكبيرة والعلامة التجارية (يماثل روح الشعار)
  static TextStyle get _brandFont => GoogleFonts.baloo2();

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        brightness: Brightness.light,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      fontFamily: _baseArabicFont.fontFamily,
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _brandFont.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
        ),
      ),
      textTheme: base.textTheme.apply(
        fontFamily: _baseArabicFont.fontFamily,
        bodyColor: AppColors.textDark,
        displayColor: AppColors.textDark,
      ).copyWith(
        headlineLarge: _brandFont.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
        ),
        headlineMedium: _brandFont.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: _baseArabicFont.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: _baseArabicFont.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: _baseArabicFont.copyWith(color: AppColors.textGrey),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: _baseArabicFont.copyWith(
            fontSize: 11, fontWeight: FontWeight.w700),
        unselectedLabelStyle: _baseArabicFont.copyWith(fontSize: 11),
      ),
    );
  }
}

/// معلومات الأقسام السبعة الرئيسية للتطبيق
enum AppSection {
  sale('البيع', 'شراء وبيع القطط', AppColors.sectionSale),
  mating('التزاوج', 'خدمة تزاوج آمنة وموثوقة', AppColors.sectionMating),
  adoption('التبني', 'امنح حياة جديدة لقط ينتظرك', AppColors.sectionAdoption),
  food('الأطعمة', 'أنظمة صحية ومغذية للقطط', AppColors.sectionFood),
  accessories('الإكسسوارات واللوازم', 'كل مستلزمات القطط في مكان واحد',
      AppColors.sectionAccessories),
  hotel('الفندقة', 'إقامة فاخرة وآمنة لرعاية الأنواع', AppColors.sectionHotel),
  vet('البيطرة', 'استشارات وعلاج ورعاية صحية متكاملة',
      AppColors.sectionVet);

  final String title;
  final String subtitle;
  final Color color;

  const AppSection(this.title, this.subtitle, this.color);
}
