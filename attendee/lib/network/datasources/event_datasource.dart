import "package:attendee/domain/models/event.dart";
import "package:attendee/network/constants/api_endpoint_constants.dart";
import "package:dio/dio.dart";
import "package:retrofit/retrofit.dart";

part "event_datasource.g.dart";

@RestApi()
abstract class EventDatasource {
  factory EventDatasource(Dio dio) = _EventDatasource;

  @GET(ApiEndpointConstants.events)
  Future<List<Event>> getEvents();
}
