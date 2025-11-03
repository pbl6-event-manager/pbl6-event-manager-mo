import 'package:attendee/domain/models/event.dart';
import 'package:attendee/ui/common_widgets/error_page.dart';
import 'package:attendee/ui/managers/ui_message_manager.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/bloc/event_detail_bloc.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/widgets/event_detail_body.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/widgets/event_detail_bottom_bar.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/widgets/event_detail_image.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/enums/view_status_enum.dart';
import 'package:attendee/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({
    super.key,
    required this.eventId,
    required this.event,
  });

  final int? eventId;
  final Event? event;

  @override
  Widget build(BuildContext context) {
    return eventId == null
        ? ErrorPage()
        : BlocProvider(
            create: (context) =>
                EventDetailBloc()
                  ..add(EventDetailLoad(eventId: eventId!, event: event)),
            child: EventDetailView(),
          );
  }
}

class EventDetailView extends StatelessWidget {
  const EventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventDetailBloc, EventDetailState>(
      listener: (context, state) {
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          UiMessageManager.showErrorSnackBar(
            context: context,
            message: state.errorMessage!,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          // TODO: Get pricing string here
          bottomNavigationBar: EventDetailBottomBar(
            isHidden:
                state.status == ViewStatusEnum.loading ||
                state.status == ViewStatusEnum.initial,
            onGetTicketTapped: _onGetTicketTapped,
            dateTimeString: state.event?.date?.shortString,
            pricingString: "Pricing",
          ),
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () => _onShareTapped(context),
                icon: Icon(Icons.ios_share),
              ),
              IconButton(
                onPressed: () => _onFavouriteTapped(context),
                icon: Icon(Icons.favorite_border),
              ),
            ],
            actionsPadding: EdgeInsets.only(
              right: UIConstants.horizontalPadding,
            ),
          ),
          body: state.status == ViewStatusEnum.failure
              ? SizedBox.shrink()
              : RefreshIndicator(
                  onRefresh: () async =>
                      context.read<EventDetailBloc>().add(EventDetailRefresh()),
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 20),
                    children: [
                      EventDetailImage(state: state),
                      SizedBox(height: 32),
                      EventDetailBody(
                        state: state,
                        onCopyAddressTapped: () =>
                            _onCopyAddressTapped(context),
                        onContactTapped: _onContactTapped,
                        onFollowTapped: _onFollowTapped,
                        onRelatedEventTapped: _onRelatedEventTapped,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  void _onFollowTapped() {}

  void _onContactTapped() {}

  void _onRelatedEventTapped(Event event) {}

  void _onFavouriteTapped(BuildContext context) {
    final bloc = context.read<EventDetailBloc>();
    final currentEvent = bloc.state.event;
    bloc.add(
      EventDetailFavoritePressed(
        eventId: currentEvent?.id,
        event: currentEvent,
      ),
    );
  }

  void _onCopyAddressTapped(BuildContext context) {
    final bloc = context.read<EventDetailBloc>();
    final currentEvent = bloc.state.event;
    bloc.add(
      EventDetailAddressCopyPressed(
        eventId: currentEvent?.id,
        event: currentEvent,
      ),
    );
  }

  void _onShareTapped(BuildContext context) {
    final bloc = context.read<EventDetailBloc>();
    final currentEvent = bloc.state.event;
    bloc.add(
      EventDetailSharePressed(eventId: currentEvent?.id, event: currentEvent),
    );
  }

  void _onGetTicketTapped() {}
}
