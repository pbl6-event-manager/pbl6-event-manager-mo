import "package:attendee/utils/helpers/result.dart";

abstract class CheckEmailRepository {
  Future<Result<bool>> checkIfEmailExists({required String email});
}
