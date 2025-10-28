part of "acccount_setting_bloc.dart";

sealed class AccountSettingEvent extends Equatable {
  const AccountSettingEvent();
  @override
  List<Object?> get props => [];
}

class AccountFirstNameFieldChanged extends AccountSettingEvent {
  final String? firstNameValue;
  const AccountFirstNameFieldChanged({required this.firstNameValue});
  @override
  List<Object?> get props => [firstNameValue];
}

class AccountLastNameFieldChanged extends AccountSettingEvent {
  final String? lastNameValue;
  const AccountLastNameFieldChanged({required this.lastNameValue});
  @override
  List<Object?> get props => [lastNameValue];
}

class AccountPhoneNumberFieldChanged extends AccountSettingEvent {
  final String? phoneNumberValue;
  const AccountPhoneNumberFieldChanged({required this.phoneNumberValue});
  @override
  List<Object?> get props => [phoneNumberValue];
}
