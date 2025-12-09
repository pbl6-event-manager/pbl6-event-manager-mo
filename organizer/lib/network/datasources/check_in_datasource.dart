import 'package:dio/dio.dart';
import 'package:organizer/domain/models/attendee.dart';
import 'package:organizer/network/constants/api_endpoint_constants.dart';
import 'package:retrofit/retrofit.dart';

part 'check_in_datasource.g.dart';

@RestApi()
abstract class CheckInDatasource {
  factory CheckInDatasource(Dio dio) = _CheckInDatasource;

  @GET(ApiEndpointConstants.checkIn)
  Future<Attendee> checkIn({@Path('id') required String checkInCode});
}
