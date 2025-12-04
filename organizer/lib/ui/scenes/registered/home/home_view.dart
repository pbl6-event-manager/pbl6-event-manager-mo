import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:organizer/ui/common_widgets/check_in_button.dart';
import 'package:organizer/ui/scenes/registered/home/home_navigator.dart';
import 'package:organizer/utils/constants/app_string_constant.dart';
import 'package:organizer/utils/constants/ui_constant.dart';

import 'package:organizer/utils/extensions/context_extension.dart';
import 'package:organizer/utils/extensions/datetime_extension.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<HomeNavigator>(
      create: (context) => HomeNavigatorImpl(goRouter: GoRouter.of(context)),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Remove dummy data
    final List<(String name, bool isCheckedIn)> dummyString = List.generate(
      32,
      (index) => ("Number index $index", index % 4 == 0),
    );

    final HomeNavigator navigator = context.read<HomeNavigator>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorPalette.secondary,
        title: _buildAppBar(
          context,
          onEventNameTapped: () => _onEventNameTapped(navigator),
          eventDateTime: DateTime(1979),
          eventName: "An Event",
        ),
        centerTitle: true,
        titleSpacing: UIConstant.horizontalPadding,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 120,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(100),
          ),
          onPressed: () => _goToScanQr(navigator),
          backgroundColor: context.colorPalette.branding,
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
        child: ListView.separated(
          separatorBuilder: (context, indext) =>
              Divider(color: context.colorPalette.divider, height: 0),
          itemBuilder: (context, index) =>
              _buildTile(index, context, navigator, dummyString),
          itemCount: dummyString.length,
        ),
      ),
    );
  }

  Widget _buildTile(
    int index,
    BuildContext context,
    HomeNavigator navigator,
    List<(String, bool)> dummyString,
  ) {
    final bool isReserved = dummyString[index].$2 == true;
    return ListTile(
      onTap: () => _onTicketTapped(navigator, ticketId: index),
      contentPadding: EdgeInsets.all(0),
      minVerticalPadding: 0,

      minLeadingWidth: 0,
      leading: isReserved
          ? Container(width: 8, color: context.colorPalette.success)
          : null,
      horizontalTitleGap: 8,
      trailing: Padding(
        padding: const EdgeInsets.only(right: 8 + 8),
        child: SizedBox(
          width: 100,
          child: CheckInButton(
            isReserved: isReserved,
            onTapped: isReserved
                ? () {}
                : () => _onCheckinButtonTapped(context, ticketId: index),
          ),
        ),
      ),

      title: Padding(
        padding: EdgeInsets.only(
          left: dummyString[index].$2 == true ? 0 : 8 + 8,
        ),
        child: Text(
          dummyString[index].$1,
          style: context.textPalette.headlineLarge,
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(
          left: dummyString[index].$2 == true ? 0 : 8 + 8,
        ),

        child: Text(
          dummyString[index].$2.toString(),
          style: context.textPalette.bodyLarge.copyWith(
            color: context.colorPalette.textPlaceholder,
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context, {
    required VoidCallback? onEventNameTapped,
    required String eventName,
    required DateTime eventDateTime,
  }) {
    return Ink(
      child: InkWell(
        radius: 8,
        onTap: onEventNameTapped,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // A dummy sized box to make the text always in the center
            SizedBox(width: 24 + 8),
            Flexible(
              child: Column(
                children: [
                  Text(
                    eventName,
                    style: context.textPalette.headlineLarge.copyWith(
                      color: context.colorPalette.invertedText,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    eventDateTime.string,
                    style: context.textPalette.labelLarge.copyWith(
                      color: context.colorPalette.invertedText,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),

            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: context.colorPalette.surfaceContainer,
            ),
          ],
        ),
      ),
    );
  }

  void _goToScanQr(HomeNavigator navigator) {
    navigator.goToQRScan();
  }

  void _onTicketTapped(HomeNavigator navigator, {required int ticketId}) {
    navigator.goToTicketDetail(ticketId: ticketId);
  }

  void _onCheckinButtonTapped(BuildContext context, {required int ticketId}) {}

  void _onEventNameTapped(HomeNavigator navigator) {
    navigator.goToEventList();
  }
}
