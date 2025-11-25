import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_attendee_info.g.dart';

@JsonSerializable(createFactory: false)
class TicketAttendeeInfo extends Equatable {
  const TicketAttendeeInfo({
    required this.ticketId,
    required this.fullName,
    required this.email,
    required this.price,
  });

  final int ticketId;
  final String fullName;
  final String email;
  final double price;

  bool get isComplete => fullName.trim().isNotEmpty && email.trim().isNotEmpty;

  TicketAttendeeInfo copyWith({
    int? ticketId,
    String? fullName,
    String? email,
    double? price,
  }) {
    return TicketAttendeeInfo(
      ticketId: ticketId ?? this.ticketId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [ticketId, fullName, email, price];

  Map<String, dynamic> toJson() => _$TicketAttendeeInfoToJson(this);
}
