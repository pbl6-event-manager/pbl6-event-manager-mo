part of 'sign_in_bloc.dart';

final class SignInState extends Equatable {
  const SignInState({required this.status, required this.errorMessage});

  final ViewStatusEnum status;
  final String? errorMessage;

  factory SignInState.initial() =>
      SignInState(status: ViewStatusEnum.initial, errorMessage: null);

  SignInState copyWith({ViewStatusEnum? status, String? errorMessage}) {
    return SignInState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
