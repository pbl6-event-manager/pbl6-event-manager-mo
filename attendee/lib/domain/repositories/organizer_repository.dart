import 'package:attendee/domain/models/organizer.dart';
import 'package:attendee/utils/helpers/result.dart';

abstract class OrganizerRepository {
  Future<Result<Organizer>> getOrganizerById({required int organizerId});
}
