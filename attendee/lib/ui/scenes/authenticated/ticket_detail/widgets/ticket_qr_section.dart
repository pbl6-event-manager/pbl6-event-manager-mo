import 'package:attendee/ui/common_widgets/common_image_carousel.dart';
import 'package:attendee/ui/scenes/authenticated/ticket_detail/widgets/qr_page_indicator.dart';
import 'package:flutter/material.dart';

class TicketQrSection extends StatelessWidget {
  const TicketQrSection({
    super.key,
    required this.imageUrls,
    required this.onPageChanged,
    required this.pageIndexNotifier,
  });

  final List<String> imageUrls;
  final ValueChanged<int> onPageChanged;
  final ValueNotifier<int> pageIndexNotifier;

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return const SizedBox.shrink();
    }

    // TODO: Replace with stateful current index once bloc is added

    final totalPages = imageUrls.length;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: CommonImageCarousel(
            cornerRadius: 0,
            imageUrls: imageUrls,
            height: 180,
            boxFit: BoxFit.contain,
            enableSizeAnimation: true,
            inactivePageScale: 0.5,
            showIndicator: false,
            onPageChanged: onPageChanged,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: pageIndexNotifier,
          builder: (context, value, child) =>
              QrPageIndicator(currentPage: value, totalPages: totalPages),
        ),
        const Divider(),
      ],
    );
  }
}
