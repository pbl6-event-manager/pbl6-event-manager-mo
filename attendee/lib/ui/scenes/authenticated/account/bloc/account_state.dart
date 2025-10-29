part of 'account_bloc.dart';

final class AccountState extends Equatable {
  final ViewStatusEnum status;
  final String? errorMessage;
  final User? user;

  final bool isUpdatingAcount;

  const AccountState({
    required this.status,
    required this.errorMessage,
    required this.user,
    required this.isUpdatingAcount,
  });

  const AccountState.initial()
    : status = ViewStatusEnum.initial,
      errorMessage = null,
      user = null,
      isUpdatingAcount = false;

  AccountState copyWith({
    ViewStatusEnum? status,
    String? errorMessage,
    User? user,
    bool? isUpdatingAcount,
  }) {
    return AccountState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      isUpdatingAcount: isUpdatingAcount ?? this.isUpdatingAcount,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, user, isUpdatingAcount];
}
