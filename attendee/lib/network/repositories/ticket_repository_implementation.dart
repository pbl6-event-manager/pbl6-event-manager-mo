import 'package:attendee/domain/models/ticket.dart';
import 'package:attendee/domain/repositories/ticket_repository.dart';
import 'package:attendee/network/datasources/ticket_datasource.dart';
import 'package:attendee/utils/helpers/result.dart';

final class TicketRepositoryImplementation implements TicketRepository {
  final TicketDatasource _datasource;

  const TicketRepositoryImplementation({required TicketDatasource datasource})
    : _datasource = datasource;

  @override
  Future<Result<List<Ticket>>> getTicketsByEventId({
    required int eventId,
  }) async {
    try {
      final ticketResult = await _datasource.getTicketsByEventId(id: eventId);
      return Result.ok(ticketResult);
    } catch (error) {
      return Result.error(error);
    }
  }
}
