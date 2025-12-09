import 'package:organizer/domain/models/attendee.dart';
import 'package:organizer/domain/models/order_attendee.dart';
import 'package:organizer/utils/helpers/result.dart';

abstract class OrderRepository {
  Future<Result<List<OrderAttendee>>> getOrderAttendees({required int eventId});

  Future<Result<List<Attendee>>> getAttendees({required int eventId});
}
