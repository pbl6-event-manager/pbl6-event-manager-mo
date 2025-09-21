import "package:equatable/equatable.dart";

abstract class EmailInitalEvent extends Equatable {
  const EmailInitalEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends EmailInitalEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class EmailCompleted extends EmailInitalEvent {
  const EmailCompleted();
}

class EmailSubmitted extends EmailInitalEvent {
  const EmailSubmitted();
}
