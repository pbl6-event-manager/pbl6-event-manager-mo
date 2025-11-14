import 'package:attendee/application/app_router.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/assets_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/enums/app_route_enum.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CheckoutSuccessPage extends StatelessWidget {
  const CheckoutSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CheckoutSuccessView();
  }
}

class CheckoutSuccessView extends StatelessWidget {
  const CheckoutSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomBar(),
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

  Widget _buildBottomBar() {
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
            onPressed: _onViewTicketTapped,
            child: Text(
              AppStringConstants.checkoutSuccess.viewTicketButtonLabel,
            ),
          ),
          SizedBox(height: 4),
          OutlinedButton(
            onPressed: _onReturnToHomeTapped,
            child: Text(
              AppStringConstants.checkoutSuccess.returnHomeButtonLabel,
            ),
          ),
        ],
      ),
    );
  }

  void _onViewTicketTapped() {}

  void _onReturnToHomeTapped() {
    GetIt.instance<AppRouter>().router.goNamed(AppRouteEnum.home.name);
  }
}
