import 'package:attendee/domain/models/order.dart';
import 'package:attendee/network/constants/api_endpoint_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'order_datasource.g.dart';

@RestApi()
abstract class OrderDatasource {
  factory OrderDatasource(Dio dio) = _OrderDatasource;

  @GET(ApiEndpointConstants.myOrder)
  Future<List<Order>> getMyOrders();
}
