import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/cat_item.dart';
import '../home/main_nav_shell.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final CatItem item;
  final double totalPrice;
  final String orderId;

  const PaymentSuccessScreen({
    super.key,
    required this.item,
    required this.totalPrice,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 52),
              ),
              const SizedBox(height: 24),
              Text('تم الحجز بنجاح!',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 8),
              Text('رقم الحجز #$orderId',
                  style: const TextStyle(color: AppColors.textGrey)),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('المنتج/الخدمة'),
                        Text(item.title,
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('المبلغ المدفوع'),
                        Text(
                          totalPrice == 0
                              ? 'مجاناً'
                              : '${totalPrice.toStringAsFixed(0)} ${item.currency}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const MainNavShell()),
                      (route) => false,
                    );
                  },
                  child: const Text('العودة للرئيسية'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('عرض تفاصيل الحجز'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
