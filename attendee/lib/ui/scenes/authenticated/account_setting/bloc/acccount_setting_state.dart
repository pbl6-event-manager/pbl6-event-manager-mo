part of "acccount_setting_bloc.dart";

final class AccountSettingState extends Equatable {
  const AccountSettingState({
    required this.initialFirstName,
    required this.initialLastName,
    required this.initialPhoneNumber,
    required this.currentFirstName,
    required this.currentLastName,
    required this.currentPhoneNumber,
    required this.firstNameValidationLabel,
    required this.lastNameValidationLabel,
    required this.phoneNumberValidationLabel,
    required this.selectedProfileImage,
  });

  const AccountSettingState.initial()
    : initialFirstName = null,
      initialLastName = null,
      initialPhoneNumber = null,
      currentFirstName = null,
      currentLastName = null,
      currentPhoneNumber = null,
      firstNameValidationLabel = null,
      lastNameValidationLabel = null,
      phoneNumberValidationLabel = null,
      selectedProfileImage = null;

  const AccountSettingState.fromInitialData({
    required String? firstName,
    required String? lastName,
    required String? phoneNumber,
  }) : initialFirstName = firstName,
       initialLastName = lastName,
       initialPhoneNumber = phoneNumber,
       currentFirstName = firstName,
       currentLastName = lastName,
       currentPhoneNumber = phoneNumber,
       firstNameValidationLabel = null,
       lastNameValidationLabel = null,
       phoneNumberValidationLabel = null,
       selectedProfileImage = null;

  final String? initialFirstName;
  final String? initialLastName;
  final String? initialPhoneNumber;

  final String? currentFirstName;
  final String? currentLastName;
  final String? currentPhoneNumber;

  final String? firstNameValidationLabel;
  final String? lastNameValidationLabel;
  final String? phoneNumberValidationLabel;

  final XFile? selectedProfileImage;

  // Getters that return null if value hasn't changed from initial
  String? get changedFirstName =>
      currentFirstName != initialFirstName ? currentFirstName : null;

  String? get changedLastName =>
      currentLastName != initialLastName ? currentLastName : null;

  String? get changedPhoneNumber =>
      currentPhoneNumber != initialPhoneNumber ? currentPhoneNumber : null;

  // Check if profile image was selected
  bool get hasProfileImageChanged => selectedProfileImage != null;

  // Check if any field has changed
  bool get hasChanges =>
      changedFirstName != null ||
      changedLastName != null ||
      changedPhoneNumber != null ||
      hasProfileImageChanged;

  AccountSettingState copyWith({
    String? currentFirstName,
    String? currentLastName,
    String? currentPhoneNumber,
    Nullable<String>? firstNameValidationLabel,
    Nullable<String>? lastNameValidationLabel,
    Nullable<String>? phoneNumberValidationLabel,
    Nullable<XFile>? selectedProfileImage,
  }) {
    return AccountSettingState(
      initialFirstName: initialFirstName,
      initialLastName: initialLastName,
      initialPhoneNumber: initialPhoneNumber,
      currentFirstName: currentFirstName ?? this.currentFirstName,
      currentLastName: currentLastName ?? this.currentLastName,
      currentPhoneNumber: currentPhoneNumber ?? this.currentPhoneNumber,
      firstNameValidationLabel: firstNameValidationLabel != null
          ? firstNameValidationLabel.value
          : this.firstNameValidationLabel,
      lastNameValidationLabel: lastNameValidationLabel != null
          ? lastNameValidationLabel.value
          : this.lastNameValidationLabel,
      phoneNumberValidationLabel: phoneNumberValidationLabel != null
          ? phoneNumberValidationLabel.value
          : this.phoneNumberValidationLabel,
      selectedProfileImage: selectedProfileImage != null
          ? selectedProfileImage.value
          : this.selectedProfileImage,
    );
  }

  @override
  List<Object?> get props => [
    currentFirstName,
    currentLastName,
    currentPhoneNumber,
    firstNameValidationLabel,
    lastNameValidationLabel,
    phoneNumberValidationLabel,
    selectedProfileImage,
  ];
}
