import 'package:attendee/application/app_router.dart';
import 'package:attendee/domain/models/event.dart';
import 'package:attendee/domain/repositories/event_repository.dart';
import 'package:attendee/domain/repositories/organizer_repository.dart';
import 'package:attendee/domain/usecases/copy_string_to_clipboard_usecase.dart';
import 'package:attendee/ui/common_widgets/common_image_widget.dart';
import 'package:attendee/ui/common_widgets/error_page.dart';
import 'package:attendee/ui/managers/ui_message_manager.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/bloc/event_detail_bloc.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/event_detail_navigator.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/widgets/event_detail_body.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/widgets/event_detail_bottom_bar.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/enums/view_status_enum.dart';
import 'package:attendee/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
        : MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => EventDetailBloc(
                  eventRepository: GetIt.instance<EventRepository>(),
                  organizerRepository: GetIt.instance<OrganizerRepository>(),
                  copyStringToClipboardUsecase:
                      GetIt.instance<CopyStringToClipboardUsecase>(),
                )..add(EventDetailLoad(eventId: eventId!, event: event)),
              ),
              RepositoryProvider<EventDetailNavigator>(
                create: (context) => EventDetailNavigatorImplementation(
                  goRouter: GetIt.instance<AppRouter>().router,
                ),
              ),
            ],
            child: EventDetailView(),
          );
  }
}

class EventDetailView extends StatelessWidget {
  const EventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = context.read<EventDetailNavigator>();
    return BlocConsumer<EventDetailBloc, EventDetailState>(
      listener: (context, state) {
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          UiMessageManager.showErrorSnackBar(
            context: context,
            message: state.errorMessage!,
          );
        }
        if (state.uiMessage != null && state.uiMessage!.isNotEmpty) {
          UiMessageManager.showSuccessSnackBar(
            context: context,
            message: state.uiMessage!,
          );
          context.read<EventDetailBloc>().add(
            const EventDetailUiMessageCleared(),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          // TODO: Get pricing string here
          bottomNavigationBar: EventDetailBottomBar(
            primaryButtonLabel: AppStringConstants.eventDetail.getTicketButton,
            isHidden:
                state.status == ViewStatusEnum.loading ||
                state.status == ViewStatusEnum.initial,
            onPrimaryButtonTapped: () => _onGetTicketTapped(navigator, state),
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
                      if (state.event?.bannerImagePath != null &&
                          state.event!.bannerImagePath!.isNotEmpty) ...[
                        CommonImageWidget(
                          imageUrl: state.event!.bannerImagePath!,
                        ),
                        SizedBox(height: 32),
                      ],

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

  void _onGetTicketTapped(
    EventDetailNavigator navigator,
    EventDetailState state,
  ) {
    if (state.event == null) {
      return;
    }
    navigator.goToBooking(id: state.event!.id);
  }
}
