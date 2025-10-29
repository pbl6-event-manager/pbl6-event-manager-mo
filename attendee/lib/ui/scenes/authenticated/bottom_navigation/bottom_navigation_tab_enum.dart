import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:flutter/material.dart';

enum BottomNavigationTabEnum {
  home,
  tickets,
  account;

  String get title {
    return switch (this) {
      BottomNavigationTabEnum.home =>
        AppStringConstants.bottomNavigation.homeTab,
      BottomNavigationTabEnum.tickets =>
        AppStringConstants.bottomNavigation.ticketTab,
      BottomNavigationTabEnum.account =>
        AppStringConstants.bottomNavigation.accountTab,
    };
  }

  IconData get defaultIcon => switch (this) {
    BottomNavigationTabEnum.home => Icons.home_outlined,
    BottomNavigationTabEnum.tickets => Icons.confirmation_number,
    BottomNavigationTabEnum.account => Icons.account_box_outlined,
  };

  IconData get selectedIcon => switch (this) {
    BottomNavigationTabEnum.home => Icons.home,
    BottomNavigationTabEnum.tickets => Icons.local_activity,
    BottomNavigationTabEnum.account => Icons.account_box,
  };
}
