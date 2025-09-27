import "package:attendee/utils/enums/view_status_enum.dart";
import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";

part "home_event.dart";
part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<HomeLoad>(_onHomeLoad);
    on<HomeReload>(_onHomeReload);
    on<HomeChipSelected>(_onHomeChipSelected);
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
          currentLocation: "Dummy location",
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
}
