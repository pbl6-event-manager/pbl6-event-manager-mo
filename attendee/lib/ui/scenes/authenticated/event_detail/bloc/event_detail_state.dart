part of 'event_detail_bloc.dart';

sealed class EventDetailState extends Equatable {
  const EventDetailState();
  
  @override
  List<Object> get props => [];
}

final class EventDetailInitial extends EventDetailState {}
