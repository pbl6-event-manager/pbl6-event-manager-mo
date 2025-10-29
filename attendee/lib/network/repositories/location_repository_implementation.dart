import 'package:attendee/domain/repositories/location_repository.dart';
import 'package:attendee/network/datasources/location_datasource.dart';
import 'package:attendee/utils/helpers/result.dart';

class LocationRepositoryImplementation implements LocationRepository {
  final LocationDatasource _locationDatasource;

  const LocationRepositoryImplementation({
    required LocationDatasource locationDatasource,
  }) : _locationDatasource = locationDatasource;
  @override
  Future<Result<List<String>>> getCities({required String country}) async {
    try {
      final rawResponse = await _locationDatasource.getCities(country: country);
      final List<String> cities = (rawResponse.data as List<dynamic>)
          .map((city) => city.toString())
          .toList();

      return Result.ok(cities);
    } catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<String>>> getCountries() async {
    final rawResponse = await _locationDatasource.getCountries();
    final body = rawResponse.data;

    if (body is List) {
      final List<dynamic> data = body;
      final List<String> countryList = data
          .whereType<Map>()
          .map((countryItem) => countryItem['country'])
          .whereType<String>()
          .toList();
      return Result.ok(countryList);
    }

    return Result.error(Exception('Cannot fetch country list'));
  }
}
