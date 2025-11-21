import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/helpers/options.dart';
import 'package:flutter/material.dart';

enum AccountPreferenceOption implements Option {
  interest,
  friends,
  followingOrganizers,
  manageNotification,
  linkedAccounts;

  @override
  IconData get icon => switch (this) {
    AccountPreferenceOption.interest => Icons.bolt,

    AccountPreferenceOption.friends => Icons.group,

    AccountPreferenceOption.followingOrganizers => Icons.rss_feed,

    AccountPreferenceOption.manageNotification => Icons.notifications_none,

    AccountPreferenceOption.linkedAccounts => Icons.account_circle,
  };

  @override
  String get title => switch (this) {
    AccountPreferenceOption.interest =>
      AppStringConstants.account.interestOption,

    AccountPreferenceOption.friends => AppStringConstants.account.friendsOption,

    AccountPreferenceOption.followingOrganizers =>
      AppStringConstants.account.followingOrganizersOption,

    AccountPreferenceOption.manageNotification =>
      AppStringConstants.account.manageNotificationOption,

    AccountPreferenceOption.linkedAccounts =>
      AppStringConstants.account.linkedAccountsOption,
  };
}

enum AccountLegalOption implements Option {
  termsOfService,
  privacy,
  accessibility,
  cookies;

  @override
  IconData get icon => switch (this) {
    AccountLegalOption.termsOfService => Icons.article,

    AccountLegalOption.privacy => Icons.lock,

    AccountLegalOption.accessibility => Icons.accessible_forward,

    AccountLegalOption.cookies => Icons.cookie,
  };

  @override
  String get title => switch (this) {
    AccountLegalOption.termsOfService =>
      AppStringConstants.account.termsOfServiceOption,

    AccountLegalOption.privacy => AppStringConstants.account.privacyOption,

    AccountLegalOption.accessibility =>
      AppStringConstants.account.accessibilityOption,

    AccountLegalOption.cookies => AppStringConstants.account.cookiesOption,
  };
}
