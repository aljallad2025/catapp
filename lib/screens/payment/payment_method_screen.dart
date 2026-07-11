import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/cat_item.dart';
import 'payment_success_screen.dart';

enum PaymentMethod { mada, cardVisa, applePay, stcPay, bankTransfer }

class PaymentMethodScreen extends StatefulWidget {
  final CatItem item;
  final AppSection section;
  final double totalPrice;
  final DateTime? date;
  final int quantity;

  const PaymentMethodScreen({
    super.key,
    required this.item,
    required this.section,
    required this.totalPrice,
    this.date,
    this.quantity = 1,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  PaymentMethod _selected = PaymentMethod.cardVisa;
  final _cardNumberController = TextEditingController();
  final _cardNameController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  bool _processing = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardNameController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  Future<void> _confirmPayment() async {
    setState(() => _processing = true);
    // محاكاة معالجة الدفع - سيتم استبدالها بعد ربط بوابة دفع حقيقية
    // (مدى / بطاقات / Apple Pay / STC Pay) حسب اختيار ثائر لاحقاً
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _processing = false);

    final orderId =
        'CH${DateTime.now().millisecondsSinceEpoch.toString().substring(3)}';

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => PaymentSuccessScreen(
          item: widget.item,
          totalPrice: widget.totalPrice,
          orderId: orderId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('اختر طريقة الدفع')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _PaymentOptionTile(
            title: 'مدى',
            icon: Icons.credit_card,
            selected: _selected == PaymentMethod.mada,
            onTap: () => setState(() => _selected = PaymentMethod.mada),
          ),
          _PaymentOptionTile(
            title: 'بطاقة VISA / Mastercard',
            icon: Icons.credit_card,
            selected: _selected == PaymentMethod.cardVisa,
            onTap: () => setState(() => _selected = PaymentMethod.cardVisa),
          ),
          _PaymentOptionTile(
            title: 'Apple Pay',
            icon: Icons.apple,
            selected: _selected == PaymentMethod.applePay,
            onTap: () => setState(() => _selected = PaymentMethod.applePay),
          ),
          _PaymentOptionTile(
            title: 'STC Pay',
            icon: Icons.phone_iphone,
            selected: _selected == PaymentMethod.stcPay,
            onTap: () => setState(() => _selected = PaymentMethod.stcPay),
          ),
          _PaymentOptionTile(
            title: 'تحويل بنكي',
            icon: Icons.account_balance_outlined,
            selected: _selected == PaymentMethod.bankTransfer,
            onTap: () =>
                setState(() => _selected = PaymentMethod.bankTransfer),
          ),
          if (_selected == PaymentMethod.mada ||
              _selected == PaymentMethod.cardVisa) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'رقم البطاقة',
                        hintText: '1234 5678 9012 3456'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _cardNameController,
                    decoration:
                        const InputDecoration(labelText: 'اسم حامل البطاقة'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _expiryController,
                          decoration: const InputDecoration(
                              labelText: 'تاريخ الانتهاء', hintText: 'MM/YY'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _cvvController,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          decoration:
                              const InputDecoration(labelText: 'CVV'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('المبلغ الإجمالي',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text(
                  widget.totalPrice == 0
                      ? 'مجاناً'
                      : '${widget.totalPrice.toStringAsFixed(0)} ${widget.item.currency}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: AppColors.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _processing ? null : _confirmPayment,
            child: _processing
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2.5),
                  )
                : const Text('ادفع الآن'),
          ),
        ],
      ),
    );
  }
}

class _PaymentOptionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentOptionTile({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(icon,
                  color: selected ? AppColors.primary : AppColors.textGrey),
              const SizedBox(width: 12),
              Expanded(
                child: Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: selected ? AppColors.primary : AppColors.textGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
