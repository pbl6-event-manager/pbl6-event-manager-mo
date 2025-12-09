import 'package:dio/dio.dart';
import 'package:organizer/domain/models/attendee.dart';
import 'package:organizer/network/constants/api_endpoint_constants.dart';
import 'package:organizer/network/dtos/response/order_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'order_datasource.g.dart';

@RestApi()
abstract class OrderDatasource {
  factory OrderDatasource(Dio dio) = _OrderDatasource;

  @GET(ApiEndpointConstants.tickets)
  Future<List<OrderResponseDto>> getOrders({
    @Query('eventId') required int eventId,
    @Query('searchTime') String searchTime = 'THIS_YEAR',
  });

  @GET(ApiEndpointConstants.attendees)
  Future<List<Attendee>> getAttendees({@Path() required String id});
}
