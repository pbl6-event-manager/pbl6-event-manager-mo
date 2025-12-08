import 'package:json_annotation/json_annotation.dart';

part 'order_detail.g.dart';

@JsonSerializable(createToJson: false)
class OrderDetail {
  final int ticketId;
  final String ticketName;
  final String email;
  final String name;

  const OrderDetail({
    required this.ticketId,
    required this.ticketName,
    required this.email,
    required this.name,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);
}
