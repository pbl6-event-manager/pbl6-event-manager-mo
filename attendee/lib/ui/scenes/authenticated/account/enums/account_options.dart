import "package:attendee/utils/constants/app_string_constants.dart";
import "package:flutter/material.dart";

abstract class AccountOptions {
  IconData get icon;
  String get title;
}

enum AccountPreferenceOptions implements AccountOptions {
  interest,
  friends,
  followingOrganizers,
  manageNotification,
  linkedAccounts;

  @override
  IconData get icon => switch (this) {
    AccountPreferenceOptions.interest => Icons.bolt,

    AccountPreferenceOptions.friends => Icons.group,

    AccountPreferenceOptions.followingOrganizers => Icons.rss_feed,

    AccountPreferenceOptions.manageNotification => Icons.notifications_none,

    AccountPreferenceOptions.linkedAccounts => Icons.account_circle,
  };

  @override
  String get title => switch (this) {
    AccountPreferenceOptions.interest =>
      AppStringConstants.account.interestOption,

    AccountPreferenceOptions.friends =>
      AppStringConstants.account.friendsOption,

    AccountPreferenceOptions.followingOrganizers =>
      AppStringConstants.account.followingOrganizersOption,

    AccountPreferenceOptions.manageNotification =>
      AppStringConstants.account.manageNotificationOption,

    AccountPreferenceOptions.linkedAccounts =>
      AppStringConstants.account.linkedAccountsOption,
  };
}

enum AccountLegalOptions implements AccountOptions {
  termsOfService,
  privacy,
  accessibility,
  cookies;

  @override
  IconData get icon => switch (this) {
    AccountLegalOptions.termsOfService => Icons.article,

    AccountLegalOptions.privacy => Icons.lock,

    AccountLegalOptions.accessibility => Icons.accessible_forward,

    AccountLegalOptions.cookies => Icons.cookie,
  };

  @override
  String get title => switch (this) {
    AccountLegalOptions.termsOfService =>
      AppStringConstants.account.termsOfServiceOption,

    AccountLegalOptions.privacy => AppStringConstants.account.privacyOption,

    AccountLegalOptions.accessibility =>
      AppStringConstants.account.accessibilityOption,

    AccountLegalOptions.cookies => AppStringConstants.account.cookiesOption,
  };
}
