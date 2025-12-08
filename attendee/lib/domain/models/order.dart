import 'package:attendee/domain/models/order_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

enum OrderStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('CANCELED')
  canceled,
  @JsonValue('PAID')
  paid,
}

@JsonSerializable(createToJson: false)
class Order {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String totalAmount;
  final String totalAmountBeforeVoucher;
  final int eventId;
  final OrderStatus status;
  final String? appliedVoucherCode;
  final List<OrderDetail> orderDetails;

  const Order({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.totalAmount,
    required this.totalAmountBeforeVoucher,
    required this.eventId,
    required this.status,
    this.appliedVoucherCode,
    required this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
