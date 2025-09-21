part of "sign_up_bloc.dart";

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class FieldChanged extends SignUpEvent {
  final String value;
  final SignUpFields type;
  const FieldChanged(this.value, this.type);

  @override
  List<Object?> get props => [value];
}

class FieldCompleted extends SignUpEvent {
  final SignUpFields type;
  const FieldCompleted(this.type);
}

class SubmitButtonTapped extends SignUpEvent {
  const SubmitButtonTapped();
}

class PasswordSecuredButtonTapped extends SignUpEvent {
  const PasswordSecuredButtonTapped();
}
