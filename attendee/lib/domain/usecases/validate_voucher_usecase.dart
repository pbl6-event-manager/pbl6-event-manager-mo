import 'package:attendee/domain/models/user.dart';
import 'package:attendee/domain/repositories/ticket_repository.dart';
import 'package:attendee/domain/repositories/user_repository.dart';
import 'package:attendee/utils/helpers/result.dart';

abstract class ValidateVoucherUsecase {
  Future<Result<double>> execute({
    required double currentTotalPricing,
    required String voucherCode,
    required int eventId,
  });
}

final class ValidateVoucherUsecaseImplementation
    implements ValidateVoucherUsecase {
  final TicketRepository _ticketRepository;
  final UserRepository _userRepository;

  const ValidateVoucherUsecaseImplementation({
    required TicketRepository ticketRepository,
    required UserRepository userRepository,
  }) : _ticketRepository = ticketRepository,
       _userRepository = userRepository;
  @override
  Future<Result<double>> execute({
    required double currentTotalPricing,
    required String voucherCode,
    required int eventId,
  }) async {
    final userResponse = await _userRepository.getUserInfo();

    if (userResponse is Error<User>) {
      return Result.error(userResponse.error);
    }

    final userId = (userResponse as Ok<User>).value.id;

    return _ticketRepository.getDiscountedPriceThroughVoucher(
      currentTotalPricing: currentTotalPricing,
      voucherCode: voucherCode,
      eventId: eventId,
      userId: userId,
    );
  }
}
