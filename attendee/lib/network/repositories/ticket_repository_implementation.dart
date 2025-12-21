import 'package:attendee/domain/models/ticket.dart';
import 'package:attendee/domain/models/ticket_attendee_info.dart';
import 'package:attendee/domain/repositories/ticket_repository.dart';
import 'package:attendee/network/datasources/ticket_datasource.dart';
import 'package:attendee/network/dtos/requests/ticket_order_request_dto.dart';
import 'package:attendee/utils/helpers/result.dart';

final class TicketRepositoryImplementation implements TicketRepository {
  final TicketDatasource _datasource;

  const TicketRepositoryImplementation({required TicketDatasource datasource})
    : _datasource = datasource;

  @override
  Future<Result<List<Ticket>>> getTicketsByEventId({
    required int eventId,
  }) async {
    try {
      final ticketResult = await _datasource.getTicketsByEventId(id: eventId);
      return Result.ok(ticketResult);
    } catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<double>> getDiscountedPriceThroughVoucher({
    required double currentTotalPricing,
    required String voucherCode,
    required int eventId,
    required int userId,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'code': voucherCode,
        'orderAmount': currentTotalPricing,
        'eventId': eventId,
        'userId': userId,
      };
      final rawResponse = await _datasource.validateVoucher(data: data);

      final dynamic payload = rawResponse.data;

      if (payload is Map<String, dynamic> &&
          payload['finalAmount'] != null &&
          payload['error'] == null) {
        final finalAmount = (payload['finalAmount'] as num).toDouble();
        return Result.ok(finalAmount);
      }
      return Result.error(Exception(payload['error']));
    } catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<String>> placeOrder({
    required List<TicketAttendeeInfo> tickets,
    required int eventId,
    required double totalPrice,
    double? discountedTotalPrice,
    String? voucherCode,
  }) async {
    try {
      final TicketOrderRequestDto dto = TicketOrderRequestDto(
        orderDetails: tickets,
        eventId: eventId,
        totalAmountBeforeVoucher: totalPrice,
        totalAmountAfterVoucher: discountedTotalPrice ?? totalPrice,
        appliedVoucherCode: voucherCode,
      );

      final rawResponse = await _datasource.placeOrder(data: dto.toJson());

      final dynamic payload = rawResponse.data;

      if (payload is Map<String, dynamic> &&
          payload['url'] != null &&
          payload['error'] == null) {
        return Result.ok(payload['url']);
      }
      return Result.error(Exception('Data response is not valid'));
    } catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> validateOrder({required String sessionId}) async {
    try {
      await _datasource.validateOrder(sessionId: sessionId);
      return Result.ok(null);
    } catch (error) {
      return Result.error(error);
    }
  }
}
