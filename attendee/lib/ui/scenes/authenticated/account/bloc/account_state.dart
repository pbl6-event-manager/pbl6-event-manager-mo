part of "account_bloc.dart";

final class AccountState extends Equatable {
  final ViewStatusEnum status;
  final String? errorMessage;
  final User? user;

  const AccountState({
    required this.status,
    required this.errorMessage,
    required this.user,
  });

  const AccountState.initial()
    : status = ViewStatusEnum.initial,
      errorMessage = null,
      user = null;

  AccountState copyWith({
    ViewStatusEnum? status,
    String? errorMessage,
    User? user,
  }) {
    return AccountState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, user];
}
