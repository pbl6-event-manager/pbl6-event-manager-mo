import "package:equatable/equatable.dart";

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class PasswordChanged extends SignInEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class PasswordCompleted extends SignInEvent {
  const PasswordCompleted();
}

class PasswordSubmitted extends SignInEvent {
  const PasswordSubmitted();
}

class PasswordSecuredButtonTapped extends SignInEvent {
  const PasswordSecuredButtonTapped();
}
