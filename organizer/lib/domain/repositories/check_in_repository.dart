import 'package:organizer/domain/models/attendee.dart';
import 'package:organizer/utils/helpers/result.dart';

abstract class CheckInRepository {
  Future<Result<Attendee>> checkIn({required String checkInCode});
}
