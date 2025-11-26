import 'package:attendee/domain/models/ticket.dart';
import 'package:attendee/network/constants/api_endpoint_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'ticket_datasource.g.dart';

@RestApi()
abstract class TicketDatasource {
  factory TicketDatasource(Dio dio) = _TicketDatasource;

  @GET(ApiEndpointConstants.ticketByEventId)
  Future<List<Ticket>> getTicketsByEventId({@Path('id') required int id});

  @POST(ApiEndpointConstants.validateVoucher)
  Future<HttpResponse> validateVoucher({
    @Body() required Map<String, dynamic> data,
  });

  @POST(ApiEndpointConstants.bookingTicket)
  Future<HttpResponse> placeOrder({@Body() required Map<String, dynamic> data});

  @GET(ApiEndpointConstants.orderValidation)
  Future<void> validateOrder({@Path('id') required String sessionId});
}
