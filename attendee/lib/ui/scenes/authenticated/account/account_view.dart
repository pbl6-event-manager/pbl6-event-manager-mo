import "package:attendee/ui/scenes/authenticated/account/enums/account_options.dart";
import "package:attendee/ui/scenes/authenticated/account/widgets/account_app_bar.dart";
import "package:attendee/ui/scenes/authenticated/account/widgets/account_general_info_card.dart";
import "package:attendee/ui/scenes/authenticated/account/widgets/account_option_list.dart";
import "package:attendee/ui/scenes/authenticated/account/widgets/app_version_row.dart";
import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AccountView();
  }
}

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  String get name => "Name";
  String? get address => "Address";
  int? get attendedEventCount => 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccountAppBar(
        onNotificationTapped: _onNotificationPressed,
        onSettingTapped: _onSettingPressed,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: UIConstants.horizontalPadding,
          ),
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) => ListView(
    children: [
      SizedBox(height: 20),
      AccountGeneralInfoCard(
        name: name,
        address: address,
        attendedEventCount: attendedEventCount,
      ),
      SizedBox(height: 20),
      _buildOptionSectionWithTitle(
        context,
        title: AppStringConstants.account.preferencesSection,
        child: AccountOptionList<AccountPreferenceOptions>(
          options: AccountPreferenceOptions.values,
          onOptionTapped: _onPreferenceOptionTapped,
        ),
      ),
      SizedBox(height: 20),
      _buildOptionSectionWithTitle(
        context,
        title: AppStringConstants.account.helpSection,
        child: _buildHelpCenterListTile(context),
      ),

      SizedBox(height: 20),
      _buildOptionSectionWithTitle(
        context,
        title: AppStringConstants.account.legalSection,
        child: AccountOptionList<AccountLegalOptions>(
          options: AccountLegalOptions.values,
          onOptionTapped: _onLegalOptionTapped,
        ),
      ),
      SizedBox(height: 12),
      AppVersionRow(),
      SizedBox(height: 20),
      _buildLogoutTile(context),
      SizedBox(height: 40),
    ],
  );

  Widget _buildHelpCenterListTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.question_mark_rounded),
      title: Text(
        AppStringConstants.account.browseHelpCenter,
        style: context.textPalette.bodyLarge,
      ),
      onTap: () => _onHelpCenterPressed(),
      contentPadding: EdgeInsets.zero,
      trailing: Icon(Icons.chevron_right_outlined),
    );
  }

  Widget _buildOptionSectionWithTitle(
    BuildContext context, {
    required String title,
    required Widget child,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 12,
    children: [
      Text(title, style: context.textPalette.headlineLarge),
      child,
    ],
  );

  Widget _buildLogoutTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.logout),
      title: Text(
        AppStringConstants.account.signOutLabel,
        style: context.textPalette.bodyLarge,
      ),
      onTap: () => _onLogoutPressed(),
      contentPadding: EdgeInsets.zero,
    );
  }

  void _onNotificationPressed() {
    // TODO: Navigate to notifications page
  }

  void _onSettingPressed() {
    // TODO: Navigate to settings page
  }

  void _onPreferenceOptionTapped(AccountPreferenceOptions option) {
    switch (option) {
      case AccountPreferenceOptions.interest:
        break;
      case AccountPreferenceOptions.friends:
        break;
      case AccountPreferenceOptions.followingOrganizers:
        break;
      case AccountPreferenceOptions.manageNotification:
        break;
      case AccountPreferenceOptions.linkedAccounts:
        break;
    }
  }

  void _onLegalOptionTapped(AccountLegalOptions option) {
    switch (option) {
      case AccountLegalOptions.termsOfService:
        break;
      case AccountLegalOptions.privacy:
        break;
      case AccountLegalOptions.accessibility:
        break;
      case AccountLegalOptions.cookies:
        break;
    }
  }

  void _onHelpCenterPressed() {}

  void _onLogoutPressed() {}
}
