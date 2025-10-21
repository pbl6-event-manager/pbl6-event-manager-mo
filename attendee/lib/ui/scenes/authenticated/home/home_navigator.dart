import "package:attendee/application/base_navigator.dart";
import "package:attendee/utils/enums/app_route_enum.dart";

import "package:go_router/go_router.dart";

abstract class HomeNavigator extends BaseNavigator {
  Future<void> goToSearch({
    required bool isUsingCurrentLocation,
    required void Function((String?, String?, bool)) onSearchSubmitted,
  });

  Future<void> goToFilter({
    DateTime? startDateFilter,
    DateTime? endDateFilter,
    Set<int> selectedCategories = const {},
    required void Function((DateTime?, DateTime?, Set<int>)?) onFilterApplied,
  });
}

class HomeNavigatorImplementation implements HomeNavigator {
  @override
  final GoRouter goRouter;
  const HomeNavigatorImplementation({required this.goRouter});

  @override
  Future<void> goToSearch({
    required bool isUsingCurrentLocation,
    required void Function((String?, String?, bool)) onSearchSubmitted,
  }) async {
    final Map<String, dynamic> queryParams = {
      "isUsingCurrentLocation": isUsingCurrentLocation.toString(),
    };
    final searchValues = await goRouter.pushNamed(
      AppRouteEnum.homeSearch.name,
      queryParameters: queryParams,
    );

    if (searchValues != null && searchValues is (String?, String?, bool)) {
      onSearchSubmitted(searchValues);
    }
  }

  @override
  Future<void> goToFilter({
    DateTime? startDateFilter,
    DateTime? endDateFilter,
    Set<int> selectedCategories = const {},
    required void Function((DateTime?, DateTime?, Set<int>)?) onFilterApplied,
  }) async {
    final filterData = await goRouter.pushNamed(
      AppRouteEnum.homeFilter.name,
      extra: {
        "startDate": startDateFilter,
        "endDate": endDateFilter,
        "selectedCategories": selectedCategories,
      },
    );

    if (filterData != null && filterData is (DateTime?, DateTime?, Set<int>)) {
      onFilterApplied(filterData);
    }
  }
}
