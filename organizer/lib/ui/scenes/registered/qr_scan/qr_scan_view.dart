import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:organizer/domain/repositories/check_in_repository.dart';
import 'package:organizer/ui/scenes/registered/qr_scan/qr_scan_cubit.dart';
import 'package:organizer/ui/scenes/registered/qr_scan/widgets/qr_scan_snackbar.dart';
import 'package:organizer/utils/constants/app_string_constant.dart';
import 'package:organizer/utils/extensions/context_extension.dart';
import 'package:organizer/utils/enums/view_status.dart';

class QrScanPage extends StatelessWidget {
  const QrScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          QrScanCubit(repository: GetIt.instance<CheckInRepository>()),
      child: const QrScanView(),
    );
  }
}

class QrScanView extends StatefulWidget {
  const QrScanView({super.key});

  @override
  State<QrScanView> createState() => _QrScanViewState();
}

class _QrScanViewState extends State<QrScanView> {
  late final MobileScannerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      autoStart: true,
      detectionSpeed: DetectionSpeed.noDuplicates,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(const Offset(0, -40)),
      width: 200,
      height: 200,
    );

    return BlocListener<QrScanCubit, QrScanState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _listenStateChanges,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          if (didPop) return;

          final status = context.read<QrScanCubit>().state.status;
          final shouldRefresh =
              status == ViewStatus.success || status == ViewStatus.failure;

          Navigator.of(context).pop(shouldRefresh);
        },
        child: Scaffold(
          appBar: AppBar(),
          body: Stack(
            children: [
              MobileScanner(
                controller: _controller,
                scanWindow: scanWindow,
                onDetect: (barcodes) => _onBarcodeData(context, barcodes),
              ),
              IgnorePointer(
                child: CustomPaint(
                  painter: ScanWindowPainter(
                    borderColor: context.colorPalette.divider,
                    borderRadius: BorderRadius.circular(16),
                    borderStrokeCap: StrokeCap.round,
                    borderStrokeJoin: StrokeJoin.round,
                    borderStyle: PaintingStyle.stroke,
                    borderWidth: 4,
                    color: Colors.transparent,
                    scanWindow: scanWindow,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onBarcodeData(BuildContext context, BarcodeCapture? capture) {
    if (capture == null || capture.barcodes.isEmpty) return;

    final cubit = context.read<QrScanCubit>();
    if (cubit.state.status == ViewStatus.loading) return;

    final String? code = capture.barcodes
        .map((barcode) => barcode.rawValue)
        .firstWhere(
          (value) => value != null && value.isNotEmpty,
          orElse: () => null,
        );

    if (code == null) return;

    cubit.scan(code);
  }

  void _listenStateChanges(BuildContext context, QrScanState state) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).clearSnackBars();

    switch (state.status) {
      case ViewStatus.success:
        final attendee = state.attendee;
        if (attendee == null) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: QrScanSnackbar(
              name: attendee.fullName,
              ticketType: attendee.ticketName,
            ),
            duration: const Duration(seconds: 4),
            padding: EdgeInsets.zero,
          ),
        );
      case ViewStatus.failure:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: QrScanSnackbar.error(
              name: AppStringConstant.genericErrors.tryAgainMessage,
              errorLabel: state.errorMessage ?? '',
            ),
            duration: const Duration(seconds: 4),
            padding: EdgeInsets.zero,
          ),
        );
      case ViewStatus.loading:
      case ViewStatus.initial:
        break;
    }
  }
}
