# The Cat House Oman 🐱

تطبيق Flutter شامل لخدمات ومنتجات القطط في عمان - بناءً على تصميم موكاب "The Cat House.Om".

## الحالة الحالية (الخطوة 1 من الخطة)
تم إنجازه في هذه المرحلة:
- ✅ هيكل مشروع Flutter كامل (Android جاهز للبناء)
- ✅ نظام الألوان والخطوط (Theme) مطابق لهوية الشعار (أحمر مرجاني #EA5A5A)
- ✅ شعار مؤقت معاد رسمه بنفس تصميم الشعار الأصلي (دائرة + وجه قطة + نص مقوّس)
- ✅ شاشة Splash متحركة
- ✅ ربط أولي مع Supabase (بانتظار المفاتيح الحقيقية)
- ✅ ملف codemagic.yaml جاهز لبناء APK تلقائياً

## لم يتم بعد (الخطوات القادمة)
- شاشات تسجيل الدخول / إنشاء حساب
- الصفحة الرئيسية بالأقسام السبعة
- صفحات كل قسم (بيع، تزاوج، تبني، أطعمة، إكسسوارات، فندقة، بيطرة)
- صفحة الدفع
- لوحة "حسابي"
- استبدال الشعار المؤقت بملف PNG الأصلي (إذا رفعته)

## قبل بناء APK على Codemagic، لازم:
1. أنشئ مشروع Supabase جديد على supabase.com
2. من إعدادات المشروع، انسخ:
   - Project URL
   - anon public key
3. بموقع Codemagic، افتح المشروع بعد ربطه بـ GitHub، وروح لـ:
   **Environment variables** وأضف:
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`
4. اختر workflow اسمه `android-apk` وابدأ البناء (Start new build)

## رفع المشروع على GitHub
```bash
cd cathouse_app
git init
git add .
git commit -m "الإصدار الأول: هيكل المشروع + الهوية البصرية"
git branch -M main
git remote add origin https://github.com/aljallad2025/cathouse-app.git
git push -u origin main
```

## هيكل المجلدات
```
lib/
  theme/          # الألوان والخطوط
  widgets/         # عناصر واجهة قابلة لإعادة الاستخدام (الشعار حالياً)
  screens/         # شاشات التطبيق
  services/        # الاتصال بـ Supabase
  models/          # نماذج البيانات (سيتم تعبئتها بالخطوات القادمة)
```
