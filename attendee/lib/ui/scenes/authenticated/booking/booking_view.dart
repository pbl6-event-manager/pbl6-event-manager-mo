import 'package:attendee/application/app_router.dart';
import 'package:attendee/domain/models/event.dart';
import 'package:attendee/domain/repositories/ticket_repository.dart';
import 'package:attendee/ui/common_widgets/common_text_field.dart';
import 'package:attendee/ui/common_widgets/error_page.dart';
import 'package:attendee/ui/scenes/authenticated/booking/bloc/booking_bloc.dart';
import 'package:attendee/ui/scenes/authenticated/booking/booking_navigator.dart';
import 'package:attendee/ui/scenes/authenticated/booking/widgets/booking_ticket_card.dart';
import 'package:attendee/ui/scenes/authenticated/booking/widgets/booking_view_app_bar.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/widgets/event_detail_bottom_bar.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/enums/view_status_enum.dart';
import 'package:attendee/domain/models/ticket.dart';
import 'package:attendee/utils/extensions/context_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key, required this.event});

  final Event? event;

  @override
  Widget build(BuildContext context) {
    return event != null
        ? MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    BookingBloc(repository: GetIt.instance<TicketRepository>())
                      ..add(BookingEventLoaded(event: event!)),
              ),
              RepositoryProvider<BookingNavigator>(
                create: (context) => BookingNavigatorImplementation(
                  goRouter: GetIt.instance<AppRouter>().router,
                ),
              ),
            ],
            child: const BookingView(),
          )
        : const ErrorPage();
  }
}

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  late final TextEditingController _promoCodeController;

  Ticket get sampleTicket => Ticket.dummyTicket;

  @override
  void initState() {
    super.initState();
    _promoCodeController = TextEditingController()
      ..addListener(_handlePromoCodeTextChanged);
  }

  @override
  void dispose() {
    _promoCodeController.removeListener(_handlePromoCodeTextChanged);
    _promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final BookingBloc bloc = context.read<BookingBloc>();
        final bool hasDiscount = state.currentDiscountPercentage > 0;
        final String pricingLabel = hasDiscount
            ? '${state.currentTotalPricing.toStringAsFixed(2)} '
                  '(Discount ${state.currentDiscountPercentage.toStringAsFixed(0)}%)'
            : state.currentTotalPricing.toStringAsFixed(2);
        return Scaffold(
          bottomNavigationBar: EventDetailBottomBar.expanded(
            primaryButtonLabel: AppStringConstants.booking.registerButton,
            onPrimaryButtonTapped: state.totalTicketCount == 0
                ? null
                : () =>
                      _onRegisterTapped(bloc, context.read<BookingNavigator>()),
            dateTimeString: null,
            pricingString: pricingLabel,
            isHidden: false,
            isPrimaryButtonLoading: state.isRegisterSubmitting,
          ),
          appBar: BookingAppBar(
            eventName: state.event?.title ?? '',
            eventDateTime: state.event?.startTime,
            onCloseTapped: () =>
                _onCloseTapped(context.read<BookingNavigator>()),
          ),

          body: Skeletonizer(
            enabled: state.status == ViewStatusEnum.loading,
            child: _buildBody(state, bloc, context),
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BookingState state,
    BookingBloc bloc,
    BuildContext context,
  ) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: UIConstants.horizontalPadding,
        vertical: 16,
      ),

      children: [
        CommonTextField(
          hintText: AppStringConstants.booking.promoCodePlaceholder,
          controller: _promoCodeController,
          errorText: state.promoCodeFieldErrorLabel,
          trailingIcon: _buildPromoCodeTrailing(
            state: state,
            bloc: bloc,
            context: context,
          ),
        ),
        SizedBox(height: 24),

        (state.status == ViewStatusEnum.loading)
            ? BookingTicketCard(
                ticket: sampleTicket,
                selectedTicketQuantity: 0,
                onAddTicket: null,
                onSubtractTicket: null,
              )
            : Column(
                spacing: 16,
                children: state.tickets.map((ticket) {
                  final int ticketCount = state.currentQuantityForTicket(
                    id: ticket.id,
                  );
                  return BookingTicketCard(
                    ticket: ticket,
                    selectedTicketQuantity: ticketCount,
                    onAddTicket:
                        ticketCount >= ticket.remainingQuantity ||
                            !ticket.isSaleActive
                        ? null
                        : () => _onAddTicketTapped(bloc, ticket.id),
                    onSubtractTicket: ticketCount == 0 || !ticket.isSaleActive
                        ? null
                        : () => _onSubtractTicketTapped(bloc, ticket.id),
                  );
                }).toList(),
              ),
      ],
    );
  }

  Widget _buildPromoCodeTrailing({
    required BookingState state,
    required BookingBloc bloc,
    required BuildContext context,
  }) {
    if (state.isPromoCodeSubmitting) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    final bool hasText = _promoCodeController.text.isNotEmpty;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasText)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _onPromoCodeClearTapped(bloc),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.clear,
                  size: 18,
                  color: context.colorPalette.textPlaceholder,
                ),
              ),
            ),
          ),
        if (hasText) SizedBox(width: 8),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _onPromoCodeTrailingButtonTapped(bloc),
            child: Text(
              AppStringConstants.booking.applyButton,
              style: context.textPalette.button,
            ),
          ),
        ),
      ],
    );
  }

  void _onCloseTapped(BookingNavigator navigator) {
    navigator.returnToEventDetail();
  }

  void _handlePromoCodeTextChanged() {}

  void _onPromoCodeTrailingButtonTapped(BookingBloc bloc) {
    if (bloc.state.isPromoCodeSubmitting) {
      return;
    }
    FocusScope.of(context).unfocus();
    bloc.add(
      BookingPromoCodeSubmitTapped(promoCode: _promoCodeController.text),
    );
  }

  void _onSubtractTicketTapped(BookingBloc bloc, int id) {
    bloc.add(BookingEventTicketRemovedByOne(ticketId: id));
  }

  void _onAddTicketTapped(BookingBloc bloc, int id) {
    bloc.add(BookingEventTicketAddedByOne(ticketId: id));
  }

  void _onPromoCodeClearTapped(BookingBloc bloc) {
    if (_promoCodeController.text.isEmpty) {
      return;
    }

    _promoCodeController.clear();
    bloc.add(const BookingPromoCodeCleared());
  }

  void _onRegisterTapped(BookingBloc bloc, BookingNavigator navigator) {
    if (bloc.state.isRegisterSubmitting || bloc.state.totalTicketCount == 0) {
      return;
    }
    bloc.add(const BookingEventRegisteredTapped());

    navigator.goToCheckout();
  }
}
