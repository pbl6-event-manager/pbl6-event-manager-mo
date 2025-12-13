import 'package:dio/dio.dart';
import 'package:organizer/domain/models/attendee.dart';
import 'package:organizer/network/datasources/check_in_datasource.dart';
import 'package:organizer/domain/repositories/check_in_repository.dart';
import 'package:organizer/utils/helpers/result.dart';

class CheckInRepositoryImplementation implements CheckInRepository {
  final CheckInDatasource _datasource;

  const CheckInRepositoryImplementation({required CheckInDatasource datasource})
    : _datasource = datasource;
  @override
  Future<Result<Attendee>> checkIn({required String checkInCode}) async {
    try {
      return Result.ok(await _datasource.checkIn(checkInCode: checkInCode));
    } catch (error) {
      if (error is DioException && error.response?.statusCode == 404) {
        return Result.error(Exception('Invalid QR code'));
      }
      return Result.error(error);
    }
  }
}
