import "package:attendee/utils/enums/view_status_enum.dart";
import "package:attendee/utils/helpers/nullable.dart";
import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";

part "home_event.dart";
part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<HomeLoad>(_onHomeLoad);
    on<HomeReload>(_onHomeReload);
    on<HomeChipSelected>(_onHomeChipSelected);
    on<HomeReturnedFromSearch>(_onHomeReturnedFromSearch);
    on<HomeEventSearchCleared>(_onHomeEventSearchCleared);
    on<HomeReturnedFromFilter>(_onHomeReturnedFromFilter);
  }

  Future<void> _onHomeLoad(HomeLoad event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: ViewStatusEnum.loading));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      emit(
        state.copyWith(
          status: ViewStatusEnum.success,
          chipData: [
            (1, "All Events"),
            (2, "Conferences"),
            (3, "Workshops"),
            (4, "Networking"),
            (5, "Webinars"),
            (6, "Meetups"),
            (7, "Training"),
            (8, "Social"),
          ],

          selectedChipId: 1,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeReload(HomeReload event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: ViewStatusEnum.loading));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(status: ViewStatusEnum.success, errorMessage: null));
    } catch (error) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeChipSelected(
    HomeChipSelected event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ViewStatusEnum.loading,
        selectedChipId: event.chipId,
      ),
    );

    try {
      // Simulate API call to fetch events for selected chip
      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(status: ViewStatusEnum.success, errorMessage: null));
    } catch (error) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeReturnedFromSearch(
    HomeReturnedFromSearch event,
    Emitter<HomeState> emit,
  ) async {
    if (event.searchData == null) {
      return;
    }

    final String? eventSearchQuery =
        event.searchData?.$1 != state.currentSearchQuery
        ? event.searchData?.$1
        : null;
    final String? locationSearchQuery =
        event.searchData?.$2 != state.currentLocation
        ? event.searchData?.$2
        : null;

    if (eventSearchQuery == null && locationSearchQuery == null) {
      return;
    }
    emit(
      state.copyWith(
        status: ViewStatusEnum.loading,
        currentSearchQuery: Nullable(eventSearchQuery),
        currentLocation: locationSearchQuery,
      ),
    );

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: ViewStatusEnum.success));
    } catch (error) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeEventSearchCleared(
    HomeEventSearchCleared event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ViewStatusEnum.loading,
        currentSearchQuery: Nullable(null),
        currentLocation: null,
      ),
    );

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: ViewStatusEnum.success));
    } catch (error) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeReturnedFromFilter(
    HomeReturnedFromFilter event,
    Emitter<HomeState> emit,
  ) async {
    if (event.filterData == null) {
      return;
    }

    final (DateTime? startDate, DateTime? endDate, Set<int> categories) =
        event.filterData!;

    emit(
      state.copyWith(
        status: ViewStatusEnum.loading,
        filterStartDate: Nullable(startDate),
        filterEndDate: Nullable(endDate),
        selectedCategories: categories,
      ),
    );

    try {
      // Simulate API call with filter parameters
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: ViewStatusEnum.success));
    } catch (error) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
