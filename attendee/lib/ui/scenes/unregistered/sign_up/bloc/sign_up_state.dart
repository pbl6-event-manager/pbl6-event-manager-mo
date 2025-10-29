// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'sign_up_bloc.dart';

enum SignUpFields { confirmEmail, firstName, lastName, password }

class SignUpState extends Equatable {
  final ViewStatusEnum status;
  final String originalEmail;
  final String confirmEmail;
  final String? confirmEmailError;
  final String firstName;
  final String? firstNameError;
  final String lastName;
  final String? lastNameError;
  final String password;
  final String? passwordError;
  final String? errorMessage;
  final bool isFormValid;

  final bool isPasswordSecured;

  bool get isLoading => status == ViewStatusEnum.loading;

  const SignUpState({
    required this.originalEmail,
    required this.isFormValid,
    required this.confirmEmail,
    required this.confirmEmailError,
    required this.firstName,
    required this.firstNameError,
    required this.lastName,
    required this.lastNameError,
    required this.password,
    required this.passwordError,
    required this.status,
    required this.errorMessage,
    required this.isPasswordSecured,
  });

  const SignUpState.initial({
    required this.originalEmail,
    this.isFormValid = false,
    this.confirmEmail = '',
    this.confirmEmailError,
    this.firstName = '',
    this.firstNameError,
    this.lastName = '',
    this.lastNameError,
    this.password = '',
    this.passwordError,
    this.status = ViewStatusEnum.initial,
    this.errorMessage,
    this.isPasswordSecured = true,
  });

  @override
  List<Object?> get props => [
    confirmEmail,
    confirmEmailError,
    firstName,
    firstNameError,
    lastName,
    lastNameError,
    password,
    passwordError,
    status,
    errorMessage,
    isPasswordSecured,
    isFormValid,
  ];

  SignUpState copyWith({
    bool? isFormValid,
    ViewStatusEnum? status,
    String? confirmEmail,
    String? Function()? confirmEmailError,
    String? firstName,
    String? Function()? firstNameError,
    String? lastName,
    String? Function()? lastNameError,
    String? password,
    String? Function()? passwordError,
    String? errorMessage,
    bool? isPasswordSecured,
  }) {
    return SignUpState(
      originalEmail: originalEmail,
      isFormValid: isFormValid ?? this.isFormValid,

      status: status ?? this.status,
      confirmEmail: confirmEmail ?? this.confirmEmail,
      confirmEmailError: confirmEmailError != null
          ? confirmEmailError()
          : this.confirmEmailError,
      firstName: firstName ?? this.firstName,
      firstNameError: firstNameError != null
          ? firstNameError()
          : this.firstNameError,
      lastName: lastName ?? this.lastName,
      lastNameError: lastNameError != null
          ? lastNameError()
          : this.lastNameError,
      password: password ?? this.password,
      passwordError: passwordError != null
          ? passwordError()
          : this.passwordError,
      errorMessage: errorMessage ?? this.errorMessage,
      isPasswordSecured: isPasswordSecured ?? this.isPasswordSecured,
    );
  }
}
