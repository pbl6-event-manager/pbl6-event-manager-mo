import "package:attendee/domain/models/event_category.dart";
import "package:attendee/domain/repositories/category_repository.dart";
import "package:attendee/utils/enums/date_filter_enums.dart";
import "package:attendee/utils/enums/view_status_enum.dart";
import "package:attendee/utils/extensions/date_time_extension.dart";
import "package:attendee/utils/helpers/nullable.dart";
import "package:attendee/utils/helpers/result.dart";
import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";

part "home_filter_event.dart";
part "home_filter_state.dart";

class HomeFilterBloc extends Bloc<HomeFilterEvent, HomeFilterState> {
  final CategoryRepository _categoryRepository;
  HomeFilterBloc({required CategoryRepository categoryRepository})
    : _categoryRepository = categoryRepository,
      super(HomeFilterState.initial()) {
    on<HomeFilterLoaded>(_onLoaded);
    on<HomeFilterCategoryTapped>(_onCategoryTapped);
    on<HomeFilterResetCategoryTapped>(_onCategoryResetTapped);
    on<HomeFilterResetTapped>(_onResetTapped);
    on<HomeFilterDayTapped>(_onDayTapped);
  }

  Future<void> _onLoaded(
    HomeFilterLoaded event,
    Emitter<HomeFilterState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedStartDate: Nullable(event.startDate),
        selectedEndDate: Nullable(event.endDate),
        selectedCategories: event.selectedCategoryId,
      ),
    );

    await _loadCategories(emit);
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

  Future<void> _loadCategories(Emitter<HomeFilterState> emit) async {
    final categoryResult = await _categoryRepository.getCategories();

    switch (categoryResult) {
      case Ok<List<EventCategory>>():
        emit(state.copyWith(allCategories: Nullable(categoryResult.value)));

      case Error<List<EventCategory>>():
        emit(state.copyWith(allCategories: Nullable(null)));
    }
  }
}
