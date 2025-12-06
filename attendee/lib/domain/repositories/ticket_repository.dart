import 'package:attendee/domain/models/ticket.dart';
import 'package:attendee/domain/models/ticket_attendee_info.dart';
import 'package:attendee/utils/helpers/result.dart';

abstract class TicketRepository {
  Future<Result<List<Ticket>>> getTicketsByEventId({required int eventId});
  Future<Result<double>> getDiscountedPriceThroughVoucher({
    required double currentTotalPricing,
    required String voucherCode,
    required int eventId,
    required int userId,
  });

  Future<Result<String>> placeOrder({
    required List<TicketAttendeeInfo> tickets,
    required int eventId,
    required double totalPrice,
    double? discountedTotalPrice,
    String? voucherCode,
  });

  Future<Result<void>> validateOrder({required String sessionId});
}
