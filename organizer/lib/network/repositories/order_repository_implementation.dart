import 'package:organizer/domain/models/order_attendee.dart';
import 'package:organizer/domain/repositories/order_repository.dart';
import 'package:organizer/network/datasources/order_datasource.dart';
import 'package:organizer/network/dtos/response/order_response_dto.dart';
import 'package:organizer/utils/helpers/result.dart';

final class OrderRepositoryImplementation implements OrderRepository {
  final OrderDatasource _orderDatasource;

  const OrderRepositoryImplementation({
    required OrderDatasource orderDatasource,
  }) : _orderDatasource = orderDatasource;

  @override
  Future<Result<List<OrderAttendee>>> getOrderAttendees({
    required int eventId,
  }) async {
    try {
      final List<OrderResponseDto> orders = await _orderDatasource.getOrders(
        eventId: eventId,
      );

      final List<OrderAttendee> attendees = orders
          .expand(
            (order) => order.orderDetails.map(
              (detail) => OrderAttendee(
                orderId: order.id,
                ticketId: detail.ticketId,
                ticketName: detail.ticketName,
                attendeeName: detail.name,
                email: detail.email,
              ),
            ),
          )
          .toList();

      return Result.ok(attendees);
    } catch (error) {
      return Result.error(error);
    }
  }
}
