import "package:attendee/utils/helpers/result.dart";

abstract class LocationRepository {
  Future<Result<List<String>>> getCountries();
  Future<Result<List<String>>> getCities({required String country});
}
