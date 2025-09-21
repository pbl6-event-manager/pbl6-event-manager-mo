// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:attendee/utils/enums/view_status_enum.dart';

class SignInState extends Equatable {
  final String password;
  final String? passwordError;
  final ViewStatusEnum status;
  final String? errorMessage;
  final bool isButtonEnabled;
  final bool isSecured;

  bool get isLoading => status == ViewStatusEnum.loading;

  const SignInState({
    required this.password,
    required this.passwordError,
    required this.status,
    required this.errorMessage,
    required this.isButtonEnabled,
    required this.isSecured,
  });
  const SignInState.initial({
    this.password = '',
    this.passwordError,
    this.status = ViewStatusEnum.initial,
    this.errorMessage,
    this.isButtonEnabled = false,
    this.isSecured = true,
  });

  @override
  List<Object?> get props => [
    password,
    passwordError,
    status,
    errorMessage,
    isButtonEnabled,
    isSecured,
  ];

  SignInState copyWith({
    String? password,
    String? passwordError,
    ViewStatusEnum? status,
    String? errorMessage,
    bool? isButtonEnabled,
    bool? isSecured,
  }) {
    return SignInState(
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isSecured: isSecured ?? this.isSecured,
    );
  }
}
