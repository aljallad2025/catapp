import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import 'auth/login_screen.dart';
import 'home/main_nav_shell.dart';

/// يحدد الشاشة الأولى بعد Splash حسب وجود جلسة دخول فعالة في Supabase
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return SupabaseService.isLoggedIn
        ? const MainNavShell()
        : const LoginScreen();
  }
}
