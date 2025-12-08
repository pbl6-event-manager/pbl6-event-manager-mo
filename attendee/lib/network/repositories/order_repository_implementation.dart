import 'package:attendee/domain/models/order.dart';
import 'package:attendee/domain/repositories/order_repository.dart';
import 'package:attendee/network/datasources/order_datasource.dart';
import 'package:attendee/utils/helpers/result.dart';

class OrderRepositoryImplementation implements OrderRepository {
  final OrderDatasource _datasource;

  const OrderRepositoryImplementation({required OrderDatasource datasource})
    : _datasource = datasource;
  @override
  Future<Result<List<Order>>> getMyOrder() async {
    try {
      List<Order> orders = await _datasource.getMyOrders();
      return Result.ok(orders);
    } catch (error) {
      return Result.error(error);
    }
  }
}
