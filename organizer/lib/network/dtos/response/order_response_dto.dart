import 'package:json_annotation/json_annotation.dart';

part 'order_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class OrderResponseDto {
  final int id;
  @JsonKey(defaultValue: <OrderDetailDto>[])
  final List<OrderDetailDto> orderDetails;

  const OrderResponseDto({required this.id, required this.orderDetails});

  factory OrderResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class OrderDetailDto {
  final int ticketId;
  final String? ticketName;
  final String? email;
  final String? name;

  const OrderDetailDto({
    required this.ticketId,
    this.ticketName,
    this.email,
    this.name,
  });

  factory OrderDetailDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailDtoFromJson(json);
}
