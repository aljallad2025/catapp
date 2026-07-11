import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/supabase_service.dart';
import '../../services/auth_service.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = SupabaseService.currentUser;
    final name = user?.userMetadata?['full_name'] ?? 'ضيف';
    final email = user?.email ?? '';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('حسابي')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.person, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16)),
                  Text(email,
                      style: const TextStyle(color: AppColors.textGrey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 28),
          _ProfileTile(
              icon: Icons.shopping_bag_outlined,
              label: 'طلباتي وحجوزاتي',
              onTap: () {}),
          _ProfileTile(
              icon: Icons.favorite_border,
              label: 'المفضلة',
              onTap: () {}),
          _ProfileTile(
              icon: Icons.location_on_outlined,
              label: 'عناويني',
              onTap: () {}),
          _ProfileTile(
              icon: Icons.credit_card_outlined,
              label: 'وسائل الدفع',
              onTap: () {}),
          _ProfileTile(
              icon: Icons.notifications_none_rounded,
              label: 'الإشعارات',
              onTap: () {}),
          _ProfileTile(
              icon: Icons.help_outline_rounded,
              label: 'الدعم الفني',
              onTap: () {}),
          const SizedBox(height: 12),
          _ProfileTile(
            icon: Icons.logout_rounded,
            label: 'تسجيل الخروج',
            color: AppColors.error,
            onTap: () async {
              await AuthService.signOut();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color ?? AppColors.textDark),
      title: Text(label,
          style: TextStyle(
              fontWeight: FontWeight.w600, color: color ?? AppColors.textDark)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded,
          size: 14, color: AppColors.textGrey),
      onTap: onTap,
    );
  }
}
