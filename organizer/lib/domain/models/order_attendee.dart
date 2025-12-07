import 'package:equatable/equatable.dart';

class OrderAttendee extends Equatable {
  final int orderId;
  final int ticketId;
  final String? ticketName;
  final String? attendeeName;
  final String? email;

  const OrderAttendee({
    required this.orderId,
    required this.ticketId,
    this.ticketName,
    this.attendeeName,
    this.email,
  });

  @override
  List<Object?> get props => [
    orderId,
    ticketId,
    ticketName,
    attendeeName,
    email,
  ];
}
