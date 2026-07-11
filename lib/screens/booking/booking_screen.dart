import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/cat_item.dart';
import '../payment/payment_method_screen.dart';

class BookingScreen extends StatefulWidget {
  final CatItem item;
  final AppSection section;

  const BookingScreen({super.key, required this.item, required this.section});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  int _quantity = 1;

  bool get _needsDate =>
      widget.section == AppSection.hotel ||
      widget.section == AppSection.vet ||
      widget.section == AppSection.mating;

  bool get _needsQuantity =>
      widget.section == AppSection.food ||
      widget.section == AppSection.accessories;

  double get _total => widget.item.price * (_needsQuantity ? _quantity : 1);

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('ملخص الطلب')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item.imageUrl,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        width: 64,
                        height: 64,
                        color: AppColors.border,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title,
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        Text(item.subtitle,
                            style:
                                const TextStyle(color: AppColors.textGrey, fontSize: 12)),
                      ],
                    ),
                  ),
                  Text(
                    item.price == 0
                        ? 'مجاناً'
                        : '${item.price.toStringAsFixed(0)} ${item.currency}',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (_needsDate) ...[
              Text('التاريخ',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 15)),
              const SizedBox(height: 8),
              InkWell(
                onTap: _pickDate,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined,
                          color: AppColors.primary, size: 18),
                      const SizedBox(width: 10),
                      Text(
                          '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
            if (_needsQuantity) ...[
              Text('الكمية',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 15)),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton.filled(
                    onPressed: () {
                      if (_quantity > 1) setState(() => _quantity--);
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 16),
                  Text('$_quantity',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 16),
                  IconButton.filled(
                    onPressed: () => setState(() => _quantity++),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _SummaryRow(label: 'السعر', value: item.price),
                  if (_needsQuantity)
                    _SummaryRow(
                        label: 'رسوم التوصيل', value: 1, currency: item.currency),
                  const Divider(height: 24),
                  _SummaryRow(
                    label: 'الإجمالي',
                    value: _total + (_needsQuantity ? 1 : 0),
                    bold: true,
                    currency: item.currency,
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PaymentMethodScreen(
                            item: item,
                            section: widget.section,
                            totalPrice:
                                _total + (_needsQuantity ? 1 : 0),
                            date: _needsDate ? _selectedDate : null,
                            quantity: _needsQuantity ? _quantity : 1,
                          ),
                        ),
                      );
                    },
                    child: const Text('متابعة الدفع'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool bold;
  final String currency;

  const _SummaryRow(
      {required this.label,
      required this.value,
      this.bold = false,
      this.currency = 'ر.ع'});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
      fontSize: bold ? 16 : 13,
      color: bold ? AppColors.textDark : AppColors.textGrey,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(
              value == 0
                  ? 'مجاناً'
                  : '${value.toStringAsFixed(0)} $currency',
              style: style.copyWith(
                  color: bold ? AppColors.primary : style.color)),
        ],
      ),
    );
  }
}
