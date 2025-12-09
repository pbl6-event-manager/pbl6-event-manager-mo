import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizer/domain/models/attendee.dart';
import 'package:organizer/domain/repositories/check_in_repository.dart';
import 'package:organizer/utils/enums/view_status.dart';
import 'package:organizer/utils/helpers/result.dart';

part 'qr_scan_state.dart';

class QrScanCubit extends Cubit<QrScanState> {
  QrScanCubit({required CheckInRepository repository})
    : _repository = repository,
      super(QrScanState.initial());

  final CheckInRepository _repository;

  Future<void> scan(String code) async {
    if (state.status == ViewStatus.loading) return;

    emit(
      state.copyWith(
        status: ViewStatus.loading,
        attendee: null,
        errorMessage: null,
      ),
    );

    final result = await _repository.checkIn(checkInCode: code);

    switch (result) {
      case Ok<Attendee>():
        emit(
          state.copyWith(
            status: ViewStatus.success,
            attendee: result.value,
            errorMessage: null,
          ),
        );
      case Error<Attendee>():
        emit(
          state.copyWith(
            status: ViewStatus.failure,
            attendee: null,
            errorMessage: result.toString(),
          ),
        );
    }
  }
}
