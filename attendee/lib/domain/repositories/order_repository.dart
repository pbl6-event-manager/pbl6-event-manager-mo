import 'package:attendee/domain/models/order.dart';
import 'package:attendee/utils/helpers/result.dart';

abstract class OrderRepository {
  Future<Result<List<Order>>> getMyOrder();
}
