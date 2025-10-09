import "package:attendee/domain/models/category.dart";
import "package:attendee/utils/enums/date_filter_enums.dart";
import "package:attendee/utils/enums/view_status_enum.dart";
import "package:attendee/utils/extensions/date_time_extension.dart";
import "package:attendee/utils/helpers/nullable.dart";
import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";

part "home_filter_event.dart";
part "home_filter_state.dart";

class HomeFilterBloc extends Bloc<HomeFilterEvent, HomeFilterState> {
  final List<EventCategory> allCategories;

  HomeFilterBloc(this.allCategories) : super(HomeFilterState.initial()) {
    on<HomeFilterLoaded>(_onLoaded);
    on<HomeFilterCategoryTapped>(_onCategoryTapped);
    on<HomeFilterResetCategoryTapped>(_onCategoryResetTapped);
    on<HomeFilterResetTapped>(_onResetTapped);
    on<HomeFilterDayTapped>(_onDayTapped);
  }

  void _onLoaded(HomeFilterLoaded event, Emitter<HomeFilterState> emit) {
    emit(
      state.copyWith(
        selectedStartDate: Nullable(event.startDate),
        selectedEndDate: Nullable(event.endDate),
        selectedCategories: event.selectedCategoryId,
      ),
    );
  }

  void _onCategoryTapped(
    HomeFilterCategoryTapped event,
    Emitter<HomeFilterState> emit,
  ) {
    final Set<int> currentSelectedIds = state.selectedCategories;

    // If already in the list => remove
    if (currentSelectedIds.contains(event.chosenCategoryId)) {
      emit(
        state.copyWith(
          selectedCategories: {...currentSelectedIds}
            ..remove(event.chosenCategoryId),
        ),
      );
    } else {
      // Otherwise => add to the list
      emit(
        state.copyWith(
          selectedCategories: {...currentSelectedIds}
            ..add(event.chosenCategoryId),
        ),
      );
    }
  }

  void _onCategoryResetTapped(
    HomeFilterResetCategoryTapped event,
    Emitter<HomeFilterState> emit,
  ) {
    emit(state.copyWith(selectedCategories: {}));
  }

  void _onResetTapped(
    HomeFilterResetTapped event,
    Emitter<HomeFilterState> emit,
  ) {
    emit(
      state.copyWith(
        selectedCategories: {},
        selectedStartDate: Nullable(null),
        selectedEndDate: Nullable(null),
      ),
    );
  }

  void _onDayTapped(HomeFilterDayTapped event, Emitter<HomeFilterState> emit) {
    emit(
      state.copyWith(
        selectedStartDate: Nullable(event.startDate),
        selectedEndDate: Nullable(event.endDate),
      ),
    );
  }
}
