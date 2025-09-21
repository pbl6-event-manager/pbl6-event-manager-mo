part of 'sign_in_bloc.dart';

final class SignInState extends Equatable {
  const SignInState({required this.status, required this.errorMessage});

  final ViewStatus status;
  final String? errorMessage;

  factory SignInState.initial() =>
      SignInState(status: ViewStatus.initial, errorMessage: null);

  SignInState copyWith({ViewStatus? status, String? errorMessage}) {
    return SignInState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
