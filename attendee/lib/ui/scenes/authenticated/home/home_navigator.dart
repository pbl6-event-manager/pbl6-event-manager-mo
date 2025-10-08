import "package:attendee/application/base_navigator.dart";
import "package:attendee/utils/enums/app_route_enum.dart";

import "package:go_router/go_router.dart";

abstract class HomeNavigator extends BaseNavigator {
  Future<void> goToSearch({
    required String? currentEventSearchQuery,
    required String currentLocationLabel,
    required void Function((String?, String?)) onSearchSubmitted,
  });
}

class HomeNavigatorImplementation implements HomeNavigator {
  @override
  final GoRouter goRouter;
  const HomeNavigatorImplementation({required this.goRouter});

  @override
  Future<void> goToSearch({
    required String? currentEventSearchQuery,
    required String currentLocationLabel,
    required void Function((String?, String?)) onSearchSubmitted,
  }) async {
    final Map<String, String?> queryParams = {
      "location": currentLocationLabel,
      "event": currentEventSearchQuery,
    };
    final searchValues = await goRouter.pushNamed(
      AppRouteEnum.homeSearch.name,
      queryParameters: queryParams,
    );

    if (searchValues != null && searchValues is (String?, String?)) {
      onSearchSubmitted(searchValues);
    }
  }
}
