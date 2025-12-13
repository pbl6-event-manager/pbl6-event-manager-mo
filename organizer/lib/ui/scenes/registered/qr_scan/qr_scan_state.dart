part of 'qr_scan_cubit.dart';

class QrScanState extends Equatable {
  const QrScanState({
    required this.status,
    this.attendee,
    this.errorMessage,
    this.lastCode,
  });

  final ViewStatus status;
  final Attendee? attendee;
  final String? errorMessage;
  final String? lastCode;

  factory QrScanState.initial() =>
      const QrScanState(status: ViewStatus.initial);

  QrScanState copyWith({
    ViewStatus? status,
    Attendee? attendee,
    String? errorMessage,
    Nullable<String>? lastCode,
  }) {
    return QrScanState(
      status: status ?? this.status,
      attendee: attendee,
      errorMessage: errorMessage,
      lastCode: lastCode != null ? lastCode.value : this.lastCode,
    );
  }

  @override
  List<Object?> get props => [status, attendee, errorMessage, lastCode];
}
