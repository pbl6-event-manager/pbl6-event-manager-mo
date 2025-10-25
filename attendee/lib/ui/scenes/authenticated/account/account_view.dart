import "dart:async";

import "package:attendee/application/bloc/auth_bloc.dart";
import "package:attendee/domain/repositories/user_repository.dart";
import "package:attendee/ui/scenes/authenticated/account/bloc/account_bloc.dart";
import "package:attendee/ui/scenes/authenticated/account/enums/account_options.dart";
import "package:attendee/ui/scenes/authenticated/account/widgets/account_app_bar.dart";
import "package:attendee/ui/scenes/authenticated/account/widgets/account_general_info_card.dart";
import "package:attendee/ui/scenes/authenticated/account/widgets/account_option_list.dart";
import "package:attendee/ui/scenes/authenticated/account/widgets/app_version_row.dart";
import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/enums/view_status_enum.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:skeletonizer/skeletonizer.dart";

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc(
        userRepository: GetIt.instance<UserRepository>(),
        authBloc: GetIt.instance<AuthBloc>(),
      )..add(const AccountLoad()),
      child: const AccountView(),
    );
  }
}

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state.status == ViewStatusEnum.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppStringConstants.genericErrors.tryAgainMessage),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading =
            state.status == ViewStatusEnum.loading ||
            state.status == ViewStatusEnum.initial;
        final user = state.user;

        return Scaffold(
          appBar: AccountAppBar(
            onNotificationTapped: _onNotificationPressed,
            onSettingTapped: _onSettingPressed,
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                final completer = Completer<void>();
                final subscription = context.read<AccountBloc>().stream.listen((
                  state,
                ) {
                  if (state.status != ViewStatusEnum.loading) {
                    completer.complete();
                  }
                });
                context.read<AccountBloc>().add(const AccountReload());
                await completer.future.timeout(
                  const Duration(seconds: 10),
                  onTimeout: () {},
                );
                subscription.cancel();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: UIConstants.horizontalPadding,
                ),
                child: _buildBody(
                  context,
                  isLoading: isLoading,
                  firstName: user?.firstName ?? "First",
                  lastName: user?.lastName ?? "Last",
                  address: null,
                  attendedEventCount: null,
                  imageUrl: user?.avatarUrl,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context, {
    required bool isLoading,
    required String firstName,
    required String lastName,
    required String? address,
    required int? attendedEventCount,
    required String? imageUrl,
  }) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          AccountGeneralInfoCard(
            imageUrl: imageUrl,
            firstName: firstName,
            lastName: lastName,
            address: address,
            attendedEventCount: attendedEventCount,
          ),
          const SizedBox(height: 20),
          _buildOptionSectionWithTitle(
            context,
            title: AppStringConstants.account.preferencesSection,
            child: AccountOptionList<AccountPreferenceOptions>(
              options: AccountPreferenceOptions.values,
              onOptionTapped: _onPreferenceOptionTapped,
            ),
          ),
          const SizedBox(height: 20),
          _buildOptionSectionWithTitle(
            context,
            title: AppStringConstants.account.helpSection,
            child: _buildHelpCenterListTile(context),
          ),
          const SizedBox(height: 20),
          _buildOptionSectionWithTitle(
            context,
            title: AppStringConstants.account.legalSection,
            child: AccountOptionList<AccountLegalOptions>(
              options: AccountLegalOptions.values,
              onOptionTapped: _onLegalOptionTapped,
            ),
          ),
          const SizedBox(height: 12),
          const AppVersionRow(),
          const SizedBox(height: 20),
          _buildLogoutTile(context),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHelpCenterListTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.question_mark_rounded),
      title: Text(
        AppStringConstants.account.browseHelpCenter,
        style: context.textPalette.bodyLarge,
      ),
      onTap: () => _onHelpCenterPressed(),
      contentPadding: EdgeInsets.zero,
      trailing: const Icon(Icons.chevron_right_outlined),
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
      leading: const Icon(Icons.logout),
      title: Text(
        AppStringConstants.account.signOutLabel,
        style: context.textPalette.bodyLarge,
      ),
      onTap: () => _onLogoutPressed(context),
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

  void _onLogoutPressed(BuildContext context) {
    context.read<AccountBloc>().add(const AccountLogout());
  }
}
