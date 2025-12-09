part of 'qr_scan_cubit.dart';

class QrScanState extends Equatable {
  const QrScanState({required this.status, this.attendee, this.errorMessage});

  final ViewStatus status;
  final Attendee? attendee;
  final String? errorMessage;

  factory QrScanState.initial() =>
      const QrScanState(status: ViewStatus.initial);

  QrScanState copyWith({
    ViewStatus? status,
    Attendee? attendee,
    String? errorMessage,
  }) {
    return QrScanState(
      status: status ?? this.status,
      attendee: attendee,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, attendee, errorMessage];
}
