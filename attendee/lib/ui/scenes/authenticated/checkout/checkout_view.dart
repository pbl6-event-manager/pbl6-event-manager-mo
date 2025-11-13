import 'package:attendee/domain/models/ticket.dart';
import 'package:attendee/ui/common_widgets/common_button_with_loading.dart';
import 'package:attendee/ui/common_widgets/common_text_field.dart';
import 'package:attendee/ui/scenes/authenticated/booking/bloc/booking_bloc.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/widgets/event_detail_bottom_bar.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key, required this.bookingBloc});

  final BookingBloc bookingBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: bookingBloc, child: const CheckoutView());
  }
}

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late final TextEditingController _promoCodeController;
  bool _hasPromoCodeText = false;

  @override
  void initState() {
    super.initState();
    _promoCodeController = TextEditingController()
      ..addListener(_onPromoCodeChanged);
  }

  @override
  void dispose() {
    if (mounted) {
      context.read<BookingBloc>().add(const BookingPromoCodeCleared());
    }
    _promoCodeController
      ..removeListener(_onPromoCodeChanged)
      ..dispose();
    super.dispose();
  }

  void _onPromoCodeChanged() {
    final bool hasText = _promoCodeController.text.trim().isNotEmpty;
    if (hasText != _hasPromoCodeText) {
      setState(() {
        _hasPromoCodeText = hasText;
      });
    }
  }

  void _onApplyTapped(BookingBloc bloc) {
    bloc.add(
      BookingPromoCodeSubmitTapped(promoCode: _promoCodeController.text),
    );
  }

  void _onClearTapped(BookingBloc bloc) {
    _promoCodeController.clear();
    bloc.add(const BookingPromoCodeCleared());
  }

  void _onCompleteRegistration(BookingBloc bloc) {
    if (bloc.state.isRegisterSubmitting || bloc.state.totalTicketCount == 0) {
      return;
    }
    bloc.add(const BookingEventRegisteredTapped());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final BookingBloc bloc = context.read<BookingBloc>();
        final bool hasDiscount = state.currentDiscountPercentage > 0;
        final double payableTotal = state.payableTotalPricing;
        final String pricingLabel = hasDiscount
            ? AppStringConstants.checkout.discountedPricingLabel(
                payableAmount: payableTotal,
                discountPercentage: state.currentDiscountPercentage,
              )
            : '\$${payableTotal.toStringAsFixed(2)}';

        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppStringConstants.checkout.checkoutTitle,
              style: context.textPalette.displaySmall,
            ),
          ),
          bottomNavigationBar: EventDetailBottomBar.expanded(
            primaryButtonLabel: AppStringConstants.booking.registerButton,
            onPrimaryButtonTapped: state.totalTicketCount == 0
                ? null
                : () => _onCompleteRegistration(bloc),
            dateTimeString: null,
            pricingString: pricingLabel,
            isHidden: false,
            isPrimaryButtonLoading: state.isRegisterSubmitting,
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: UIConstants.horizontalPadding,
              vertical: 24,
            ),
            children: [
              Text(
                AppStringConstants.checkout.orderSummarySectionTitle,
                style: context.textPalette.headlineLarge,
              ),
              const SizedBox(height: 16),
              ..._buildSelectedTicketSummary(context, state),
              const SizedBox(height: 32),
              Text(
                AppStringConstants.checkout.paymentMethodSectionTitle,
                style: context.textPalette.headlineLarge,
              ),
              RadioListTile(
                enabled: true,
                onChanged: (value) {},
                selected: true,
                contentPadding: EdgeInsets.all(0),
                value: true,
                groupValue: true,
                title: Text(
                  AppStringConstants.checkout.stripePaymentLabel,
                  style: context.textPalette.bodyMedium,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppStringConstants.checkout.promoCodeSectionTitle,
                style: context.textPalette.headlineLarge,
              ),
              const SizedBox(height: 12),
              CommonTextField(
                controller: _promoCodeController,
                hintText: AppStringConstants.booking.promoCodePlaceholder,
                errorText: state.promoCodeFieldErrorLabel,
                isEnabled: !state.isPromoCodeSubmitting,
                onCompleted: () => _onApplyTapped(bloc),
                trailingIcon: !_hasPromoCodeText || state.isPromoCodeSubmitting
                    ? null
                    : Icon(
                        Icons.close,
                        color: context.colorPalette.textPlaceholder,
                      ),
                onTrailingTapped: state.isPromoCodeSubmitting
                    ? null
                    : () => _onClearTapped(bloc),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: CommonButtonWithLoading(
                      label: AppStringConstants.booking.applyButton,
                      isEnabled: _hasPromoCodeText,
                      isLoading: state.isPromoCodeSubmitting,
                      onPressed: () => _onApplyTapped(bloc),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: _hasPromoCodeText && !state.isPromoCodeSubmitting
                        ? () => _onClearTapped(bloc)
                        : null,
                    child: Text(AppStringConstants.checkout.clearButtonLabel),
                  ),
                ],
              ),
              if (hasDiscount) ...[
                const SizedBox(height: 24),
                _buildDiscountBanner(context, state),
              ],
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildSelectedTicketSummary(
    BuildContext context,
    BookingState state,
  ) {
    final selectedTickets = state.tickets
        .map(
          (ticket) => (
            ticket: ticket,
            quantity: state.currentQuantityForTicket(id: ticket.id),
          ),
        )
        .where((entry) => entry.quantity > 0)
        .toList();

    return selectedTickets
        .map(
          (entry) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${entry.quantity} x ${entry.ticket.name}',
                    style: context.textPalette.bodyLarge,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  entry.ticket.type == TicketType.paid
                      ? _formatPrice(entry.ticket.price * entry.quantity)
                      : AppStringConstants.event.freePricing,
                  style: context.textPalette.labelLarge,
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  Widget _buildDiscountBanner(BuildContext context, BookingState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorPalette.success.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        AppStringConstants.checkout.discountAppliedBannerMessage(
          discountPercentage: state.currentDiscountPercentage,
          payableAmount: state.payableTotalPricing,
          originalAmount: state.currentTotalPricing,
        ),
        style: context.textPalette.bodyLarge.copyWith(
          color: context.colorPalette.onSuccess,
        ),
      ),
    );
  }

  String _formatPrice(double value) => '\$${value.toStringAsFixed(2)}';
}
