import "package:attendee/utils/enums/view_status_enum.dart";
import "package:equatable/equatable.dart";

class EmailInitialState extends Equatable {
  final String email;
  final String? emailError;
  final ViewStatusEnum status;
  final String? errorMessage;
  final bool isButtonEnabled;

  bool get isLoading => status == ViewStatusEnum.loading;

  const EmailInitialState({
    this.email = "",
    this.emailError,
    this.status = ViewStatusEnum.initial,
    this.errorMessage,
    this.isButtonEnabled = false,
  });

  EmailInitialState copyWith({
    String? email,
    String? emailError,
    ViewStatusEnum? status,
    String? errorMessage,
    bool? isButtonEnabled,
  }) {
    return EmailInitialState(
      email: email ?? this.email,
      emailError: emailError,
      status: status ?? this.status,
      errorMessage: errorMessage,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }

  @override
  List<Object?> get props => [
    email,
    emailError,
    status,
    errorMessage,
    isButtonEnabled,
  ];
}
