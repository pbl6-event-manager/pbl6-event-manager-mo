import 'package:attendee/domain/models/organizer.dart';
import 'package:attendee/network/constants/api_endpoint_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'organizer_datasource.g.dart';

@RestApi()
abstract class OrganizerDatasource {
  factory OrganizerDatasource(Dio dio) = _OrganizerDatasource;

  @GET(ApiEndpointConstants.organizerDetail)
  Future<Organizer> getOrganizerById({@Path('id') required int id});
}
