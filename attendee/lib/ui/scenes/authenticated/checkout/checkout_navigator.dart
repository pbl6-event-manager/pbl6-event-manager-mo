import 'package:attendee/application/base_navigator.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class CheckoutNavigator extends BaseNavigator {
  void goToExternalBrowser({required String withURL});
}

final class CheckoutNavigatorImplementation implements CheckoutNavigator {
  const CheckoutNavigatorImplementation({required this.goRouter});
  @override
  final GoRouter goRouter;

  @override
  void goToExternalBrowser({required String withURL}) async {
    final Uri? url = Uri.tryParse(withURL);

    if (url == null || await canLaunchUrl(url) == false) {
      return;
    }

    launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
