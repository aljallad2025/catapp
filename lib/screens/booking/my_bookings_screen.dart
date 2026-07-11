import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('حجوزاتي وطلباتي')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.receipt_long_outlined,
                  size: 64, color: AppColors.textGrey.withOpacity(0.5)),
              const SizedBox(height: 16),
              const Text(
                'لا توجد حجوزات أو طلبات بعد',
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: AppColors.textDark),
              ),
              const SizedBox(height: 6),
              const Text(
                'كل طلباتك من الأقسام السبعة ستظهر هنا\n(سيتم ربطها بجدول bookings في Supabase)',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textGrey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
