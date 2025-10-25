part of "account_bloc.dart";

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

final class AccountLoad extends AccountEvent {
  const AccountLoad();
}

final class AccountReload extends AccountEvent {
  const AccountReload();
}

final class AccountLogout extends AccountEvent {
  const AccountLogout();
}
