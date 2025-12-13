import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:organizer/application/bloc/auth_bloc.dart';
import 'package:organizer/domain/models/attendee.dart';
import 'package:organizer/domain/models/event.dart';
import 'package:organizer/domain/repositories/order_repository.dart';
import 'package:organizer/ui/scenes/registered/home/bloc/home_bloc.dart';
import 'package:organizer/ui/scenes/registered/home/home_navigator.dart';
import 'package:organizer/ui/scenes/registered/home/widgets/home_app_bar_title.dart';
import 'package:organizer/ui/scenes/registered/home/widgets/home_body.dart';
import 'package:organizer/utils/constants/app_string_constant.dart';
import 'package:organizer/utils/constants/ui_constant.dart';
import 'package:organizer/utils/extensions/context_extension.dart';
import 'package:organizer/utils/extensions/datetime_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<HomeNavigator>(
          create: (context) =>
              HomeNavigatorImpl(goRouter: GoRouter.of(context)),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            pref: GetIt.instance<SharedPreferences>(),
            orderRepository: GetIt.instance<OrderRepository>(),
            authBloc: context.read<AuthBloc>(),
          )..add(const HomeLoaded()),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeNavigator navigator = context.read<HomeNavigator>();
    final HomeBloc bloc = context.read<HomeBloc>();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final Event? selectedEvent = state.event;
        final String eventName = (selectedEvent?.title?.isNotEmpty ?? false)
            ? selectedEvent!.title!
            : AppStringConstant.home.placeholderEventName;
        final String eventDateLabel = selectedEvent?.startTime != null
            ? selectedEvent!.startTime!.string
            : AppStringConstant.home.placeholderEventDate;

        return Scaffold(
          appBar: AppBar(
            leading: SizedBox(width: 28),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => _onLogoutPressed(context, navigator),
              ),
            ],

            backgroundColor: context.colorPalette.secondary,
            title: HomeAppBarTitle(
              eventName: eventName,
              eventDateLabel: eventDateLabel,
              onTap: () => _onEventNameTapped(
                navigator,
                onEventIdReturned: (eventId) =>
                    _onEventIdReturned(bloc, event: eventId),
              ),
            ),
            centerTitle: true,
            titleSpacing: UIConstant.horizontalPadding,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
            width: 120,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(100),
              ),
              onPressed: selectedEvent == null
                  ? null
                  : () => _goToScanQr(navigator, bloc),
              backgroundColor: selectedEvent == null
                  ? context.colorPalette.disabled
                  : context.colorPalette.branding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStringConstant.home.scanQrFABLabel,
                    style: context.textPalette.labelLarge,
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.qr_code),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: HomeBody(
              state: state,
              onTicketTapped: (attendee) =>
                  _onTicketTapped(navigator, attendee: attendee),
              onRefresh: () async => _onRefreshed(bloc),
            ),
          ),
        );
      },
    );
  }

  Future<void> _goToScanQr(HomeNavigator navigator, HomeBloc bloc) async {
    final bool shouldRefresh = await navigator.goToQRScan() ?? false;

    if (shouldRefresh) {
      _onRefreshed(bloc);
    }
  }

  void _onTicketTapped(HomeNavigator navigator, {required Attendee attendee}) {
    navigator.goToTicketDetail(attendee: attendee);
  }

  void _onEventNameTapped(
    HomeNavigator navigator, {
    required void Function(Event event) onEventIdReturned,
  }) {
    navigator.goToEventList(onEventReturned: onEventIdReturned);
  }

  void _onEventIdReturned(HomeBloc bloc, {required Event event}) {
    bloc.add(HomeEventSelected(event: event));
  }

  void _onRefreshed(HomeBloc bloc) {
    bloc.add(HomeLoaded());
  }

  Future<void> _onLogoutPressed(
    BuildContext context,
    HomeNavigator navigator,
  ) async {
    final HomeBloc homeBloc = context.read<HomeBloc>();

    homeBloc.add(const HomeLogoutRequested());
    if (context.mounted) {
      navigator.goToAuth();
    }
  }
}
