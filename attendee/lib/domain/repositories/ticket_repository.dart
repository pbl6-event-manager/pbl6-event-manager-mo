import 'package:attendee/domain/models/ticket.dart';
import 'package:attendee/utils/helpers/result.dart';

abstract class TicketRepository {
  Future<Result<List<Ticket>>> getTicketsByEventId({required int eventId});
}
