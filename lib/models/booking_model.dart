import 'cat_item.dart';

enum BookingStatus { pending, confirmed, completed, cancelled }

class BookingModel {
  final String id;
  final CatItem item;
  final DateTime? date;
  final int quantity;
  final double totalPrice;
  final BookingStatus status;
  final String? paymentMethod;

  BookingModel({
    required this.id,
    required this.item,
    this.date,
    this.quantity = 1,
    required this.totalPrice,
    this.status = BookingStatus.pending,
    this.paymentMethod,
  });
}
