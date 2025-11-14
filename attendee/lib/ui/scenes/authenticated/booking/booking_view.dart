import 'package:attendee/application/app_router.dart';
import 'package:attendee/domain/models/event.dart';
import 'package:attendee/domain/repositories/ticket_repository.dart';
import 'package:attendee/domain/usecases/validate_voucher_usecase.dart';
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
                create: (context) => BookingBloc(
                  repository: GetIt.instance<TicketRepository>(),
                  validateVoucherUsecase:
                      GetIt.instance<ValidateVoucherUsecase>(),
                )..add(BookingEventLoaded(event: event!)),
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
  Ticket get sampleTicket => Ticket.dummyTicket;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final BookingBloc bloc = context.read<BookingBloc>();

        final double payableTotal = state.payableTotalPricing;
        final String pricingLabel = '\$${payableTotal.toStringAsFixed(2)}';
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

  void _onCloseTapped(BookingNavigator navigator) {
    navigator.returnToEventDetail();
  }

  void _onSubtractTicketTapped(BookingBloc bloc, int id) {
    bloc.add(BookingEventTicketRemovedByOne(ticketId: id));
  }

  void _onAddTicketTapped(BookingBloc bloc, int id) {
    bloc.add(BookingEventTicketAddedByOne(ticketId: id));
  }

  void _onRegisterTapped(BookingBloc bloc, BookingNavigator navigator) {
    if (bloc.state.isRegisterSubmitting || bloc.state.totalTicketCount == 0) {
      return;
    }
    navigator.goToCheckout(bloc: bloc);
  }
}
