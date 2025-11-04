import 'package:attendee/domain/models/organizer.dart';
import 'package:attendee/domain/repositories/organizer_repository.dart';
import 'package:attendee/network/datasources/organizer_datasource.dart';
import 'package:attendee/utils/helpers/result.dart';

final class OrganizerRepositoryImplementation implements OrganizerRepository {
  final OrganizerDatasource _datasource;

  const OrganizerRepositoryImplementation({
    required OrganizerDatasource datasource,
  }) : _datasource = datasource;
  @override
  Future<Result<Organizer>> getOrganizerById({required int organizerId}) async {
    try {
      final Organizer organizer = await _datasource.getOrganizerById(
        id: organizerId,
      );

      return Result.ok(organizer);
    } catch (error) {
      return Result.error(error);
    }
  }
}
