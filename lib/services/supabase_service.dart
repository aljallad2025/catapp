import 'package:supabase_flutter/supabase_flutter.dart';

/// نقطة وصول موحدة لعميل Supabase عبر كل شاشات التطبيق
/// سيتم توسيعها بالخطوات القادمة بدوال جلب/إضافة البيانات لكل قسم
class SupabaseService {
  SupabaseService._();

  static final SupabaseClient client = Supabase.instance.client;

  static User? get currentUser => client.auth.currentUser;

  static bool get isLoggedIn => currentUser != null;

  static Stream<AuthState> get authStateChanges =>
      client.auth.onAuthStateChange;
}
