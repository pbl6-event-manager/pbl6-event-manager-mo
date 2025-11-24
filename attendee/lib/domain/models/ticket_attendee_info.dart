import 'package:equatable/equatable.dart';

class TicketAttendeeInfo extends Equatable {
  const TicketAttendeeInfo({required this.name, required this.email});

  final String name;
  final String email;

  bool get isComplete => name.trim().isNotEmpty && email.trim().isNotEmpty;

  TicketAttendeeInfo copyWith({String? name, String? email}) {
    return TicketAttendeeInfo(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [name, email];
}
