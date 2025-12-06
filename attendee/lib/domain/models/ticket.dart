import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TicketType {
  @JsonValue('PAID')
  paid,
  @JsonValue('FREE')
  free,
}

@JsonSerializable(createToJson: false)
class Ticket {
  const Ticket({
    required this.id,
    required this.eventId,
    required this.name,
    required this.type,
    required this.priceLabel,
    required this.quantity,
    required this.soldQuantity,
    this.description,
    this.saleStartDate,
    this.saleEndDate,
    required this.isActive,
  });

  final int id;
  final int eventId;
  final String name;
  @JsonKey(unknownEnumValue: TicketType.paid)
  final TicketType type;
  @JsonKey(name: 'price')
  final String priceLabel;
  final int quantity;
  final int soldQuantity;
  final String? description;
  final DateTime? saleStartDate;
  final DateTime? saleEndDate;
  final bool isActive;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  int get remainingQuantity => quantity - soldQuantity;
  double get price => double.parse(priceLabel);

  bool get isSoldOut => remainingQuantity <= 0;

  bool get isSaleActive {
    final DateTime now = DateTime.now();
    final bool hasStarted =
        saleStartDate == null || !saleStartDate!.isAfter(now);
    final bool hasNotEnded = saleEndDate == null || !saleEndDate!.isBefore(now);
    return isActive && hasStarted && hasNotEnded && !isSoldOut;
  }

  static Ticket dummyTicket = Ticket(
    id: 1,
    eventId: 1,
    name: 'General Admission',
    type: TicketType.paid,
    priceLabel: '49.99',

    quantity: 10,
    soldQuantity: 5,
    description: 'Standard access to the event venue.',
    saleStartDate: DateTime.now().subtract(const Duration(days: 7)),
    saleEndDate: DateTime.now().add(const Duration(days: 7)),
    isActive: true,
  );
}
