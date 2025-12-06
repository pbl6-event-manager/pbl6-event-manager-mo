import 'package:attendee/domain/models/ticket_attendee_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_order_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class TicketOrderRequestDto {
  final int eventId;
  final double totalAmountBeforeVoucher;
  final double totalAmountAfterVoucher;
  final String? appliedVoucherCode;
  final List<TicketAttendeeInfo> orderDetails;

  const TicketOrderRequestDto({
    required this.orderDetails,
    required this.eventId,
    required this.totalAmountBeforeVoucher,
    required this.totalAmountAfterVoucher,
    required this.appliedVoucherCode,
  });

  Map<String, dynamic> toJson() {
    final json = _$TicketOrderRequestDtoToJson(this);
    json['isMobile'] = true;
    return json;
  }
}
