import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiEndpointConstants {
  const ApiEndpointConstants._();
  static final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  static final String _vietMapApiKey = dotenv.env['VIET_MAP_API_KEY'] ?? '';

  // AUTH
  static const String checkEmail = '/auth/check-email';
  static const String signIn = '/auth/login';
  static const String signUp = '/auth/signup';
  static const String refreshToken = '/auth/refresh-token';

  // ACCOUNT
  static const String account = '/user/profile';

  // EVENTS
  static const String events = '/events';
  static const String eventDetail = '/events/{id}';
  static const String eventsByOrganizerId = '/events/organizer/{id}';
  static const String eventsNearby = '/events/nearby';
  static const String eventsSearch = '/events/search';

  static const String ticketByEventId = '/tickets/event/{id}';

  // ORGANIZERS
  static const String organizerDetail = '/organizers/{id}';

  // External APIs
  static const String locationBaseUrl = 'https://countriesnow.space/api/v0.1';
  static const String locationCityList = '/countries/cities/q';
  static const String locationCountryList = '/countries';
  // CATEGORIES
  static const String categories = '/categories';

  // VIETMAP
  static String vietMapTileStyle =
      'https://maps.vietmap.vn/maps/styles/tm/tiles.json?apikey=$_vietMapApiKey';
}
