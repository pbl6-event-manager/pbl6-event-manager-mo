import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizer/domain/models/attendee.dart';
import 'package:organizer/domain/repositories/check_in_repository.dart';
import 'package:organizer/utils/enums/view_status.dart';
import 'package:organizer/utils/extensions/exception_extension.dart';
import 'package:organizer/utils/helpers/nullable.dart';
import 'package:organizer/utils/helpers/result.dart';

part 'qr_scan_state.dart';

class QrScanCubit extends Cubit<QrScanState> {
  Timer? _timer;

  QrScanCubit({required CheckInRepository repository})
    : _repository = repository,
      super(QrScanState.initial());

  final CheckInRepository _repository;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  Future<void> scan(String code) async {
    if (state.status == ViewStatus.loading) return;
    if (code == state.lastCode) return;

    emit(
      state.copyWith(
        status: ViewStatus.loading,
        attendee: null,
        errorMessage: null,
        lastCode: Nullable(code),
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
        _clearScanStatusAfterDelay();

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

  Future<void> _clearScanStatusAfterDelay({
    Duration duration = const Duration(seconds: 3),
  }) async {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
    _timer = Timer(duration, () {
      emit(state.copyWith(lastCode: Nullable(null)));
    });
  }
}
