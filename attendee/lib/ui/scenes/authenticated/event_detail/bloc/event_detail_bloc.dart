import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  EventDetailBloc() : super(EventDetailInitial()) {
    on<EventDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
