import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

class AuthService {
  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return SupabaseService.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) {
    return SupabaseService.client.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': fullName,
        'phone': phone,
      },
    );
  }

  static Future<void> signOut() {
    return SupabaseService.client.auth.signOut();
  }

  static Future<void> resetPassword(String email) {
    return SupabaseService.client.auth.resetPasswordForEmail(email);
  }
}
