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

  @GET(ApiEndpointConstants.eventsNearby)
  Future<List<Event>> getEventsNearby({
    @Query("latitude") required double latitude,
    @Query("longtitue") required double longitude,
    @Query("radius") required double radiusInMeter,
  });

  @GET(ApiEndpointConstants.eventsSearch)
  Future<List<Event>> searchEvents({
    @Query("keyword") required String? keyword,
    @Query("city") required String? city,
    @Query("country") required String? country,
    @Query("startDate") required String? startDate,
    @Query("endDate") required String? endDate,
    @Query("categoryIds") required List<int>? categoryIds,
  });
}
