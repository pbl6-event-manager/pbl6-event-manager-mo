import 'package:attendee/application/app_router.dart';
import 'package:attendee/ui/common_widgets/error_page.dart';
import 'package:attendee/ui/scenes/authenticated/checkout_success/bloc/checkout_success_bloc.dart';
import 'package:attendee/ui/scenes/authenticated/checkout_success/checkout_success_navigator.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/assets_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/enums/app_route_enum.dart';
import 'package:attendee/utils/enums/view_status_enum.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CheckoutSuccessPage extends StatelessWidget {
  const CheckoutSuccessPage({super.key, required this.sessionId});
  final String? sessionId;

  @override
  Widget build(BuildContext context) {
    if (sessionId == null || sessionId!.trim().isEmpty) {
      return ErrorPage(
        onButtonTapped: _goToHome,
        buttonTitle: AppStringConstants.checkoutSuccess.returnHomeButtonLabel,
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              CheckoutSuccessBloc(sessionId: sessionId!)
                ..add(const CheckoutSuccessValidateRequested()),
        ),
        RepositoryProvider<CheckoutSuccessNavigator>(
          create: (context) => CheckoutSuccessNavigatorImplementation(
            goRouter: GetIt.instance<AppRouter>().router,
          ),
        ),
      ],
      child: const CheckoutSuccessView(),
    );
  }

  void _goToHome() {
    GetIt.instance<AppRouter>().router.goNamed(AppRouteEnum.home.name);
  }
}

class CheckoutSuccessView extends StatelessWidget {
  const CheckoutSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutSuccessBloc, CheckoutSuccessState>(
      listener: (context, state) {
        if (state.status == ViewStatusEnum.failure) {
          GetIt.instance<AppRouter>().router.goNamed(AppRouteEnum.home.name);
        }
      },
      builder: (context, state) {
        final CheckoutSuccessNavigator navigator = context
            .read<CheckoutSuccessNavigator>();
        if (state.status == ViewStatusEnum.success) {
          return Scaffold(
            bottomNavigationBar: _buildBottomBar(navigator),
            body: SafeArea(
              child: ListView(
                padding: EdgeInsets.only(
                  left: UIConstants.horizontalPadding,
                  right: UIConstants.horizontalPadding,
                  top: 40,
                ),
                children: [
                  Text(
                    AppStringConstants.checkoutSuccess.title,
                    style: context.textPalette.displayLarge,
                  ),
                  SizedBox(height: 16),

                  Text(
                    AppStringConstants.checkoutSuccess.subtitle,
                    style: context.textPalette.bodyLarge.copyWith(fontSize: 18),
                  ),

                  SizedBox(height: 40),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        UIConstants.cornerRadiusBase,
                      ),
                      border: Border.all(
                        color: context.colorPalette.branding,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        UIConstants.cornerRadiusBase,
                      ),
                      child: Image.asset(AssetsConstants.checkoutSuccess),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _buildBottomBar(CheckoutSuccessNavigator navigator) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: UIConstants.horizontalPadding,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton(
            onPressed: () => _onViewTicketTapped(navigator),
            child: Text(
              AppStringConstants.checkoutSuccess.viewTicketButtonLabel,
            ),
          ),
          SizedBox(height: 4),
          OutlinedButton(
            onPressed: () => _onReturnToHomeTapped(navigator),
            child: Text(
              AppStringConstants.checkoutSuccess.returnHomeButtonLabel,
            ),
          ),
        ],
      ),
    );
  }

  void _onViewTicketTapped(CheckoutSuccessNavigator navigator) {
    navigator.goToTicket();
  }

  void _onReturnToHomeTapped(CheckoutSuccessNavigator navigator) {
    navigator.goToHome();
  }
}
