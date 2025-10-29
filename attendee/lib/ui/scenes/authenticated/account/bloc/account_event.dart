part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

final class AccountLoad extends AccountEvent {
  const AccountLoad();
}

final class AccountUpdateUserInfo extends AccountEvent {
  final ({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    XFile? profilePhoto,
  })
  userUpdateData;
  const AccountUpdateUserInfo({required this.userUpdateData});

  @override
  List<Object?> get props => [userUpdateData];
}

final class AccountRefresh extends AccountEvent {
  const AccountRefresh();
}

final class AccountLogout extends AccountEvent {
  const AccountLogout();
}
