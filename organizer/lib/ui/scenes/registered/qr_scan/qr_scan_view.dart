import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:organizer/ui/scenes/registered/qr_scan/widgets/qr_scan_snackbar.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class QrScanPage extends StatelessWidget {
  const QrScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const QrScanView();
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

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            MobileScanner(
              controller: _controller,
              scanWindow: scanWindow,
              onDetect: (barcodes) => _onBarcodeData(barcodes),
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
    );
  }

  void _onBarcodeData(BarcodeCapture? capture) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: QrScanSnackbar.error(name: "A", errorLabel: "s"),
        duration: Duration(seconds: 60),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
