import 'package:attendee/utils/helpers/nullable.dart';
import 'package:attendee/utils/validation_utils.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'acccount_setting_event.dart';
part 'acccount_setting_state.dart';

class AccountSettingBloc
    extends Bloc<AccountSettingEvent, AccountSettingState> {
  AccountSettingBloc({AccountSettingState? initialState})
    : super(initialState ?? AccountSettingState.initial()) {
    on<AccountFirstNameFieldChanged>(_onFirstNameFieldChanged);
    on<AccountLastNameFieldChanged>(_onLastNameFieldChanged);
    on<AccountPhoneNumberFieldChanged>(_onPhoneNumberFieldChanged);
    on<AccountProfilePictureChanged>(_onProfilePictureChanged);
  }

  void _onFirstNameFieldChanged(
    AccountFirstNameFieldChanged event,
    Emitter<AccountSettingState> emit,
  ) {
    final String? firstNameValidation = ValidationUtils.validateGeneralField(
      event.firstNameValue,
    );
    emit(
      state.copyWith(
        currentFirstName: event.firstNameValue,
        firstNameValidationLabel: Nullable(firstNameValidation),
      ),
    );
  }

  void _onLastNameFieldChanged(
    AccountLastNameFieldChanged event,
    Emitter<AccountSettingState> emit,
  ) {
    final String? lastNameValidation = ValidationUtils.validateGeneralField(
      event.lastNameValue,
    );
    emit(
      state.copyWith(
        currentLastName: event.lastNameValue,
        lastNameValidationLabel: Nullable(lastNameValidation),
      ),
    );
  }

  void _onPhoneNumberFieldChanged(
    AccountPhoneNumberFieldChanged event,
    Emitter<AccountSettingState> emit,
  ) {
    final String? phoneNumberValidation = ValidationUtils.validatePhoneNumber(
      event.phoneNumberValue,
    );
    emit(
      state.copyWith(
        currentPhoneNumber: event.phoneNumberValue,
        phoneNumberValidationLabel: Nullable(phoneNumberValidation),
      ),
    );
  }

  void _onProfilePictureChanged(
    AccountProfilePictureChanged event,
    Emitter<AccountSettingState> emit,
  ) {
    emit(state.copyWith(selectedProfileImage: Nullable(event.imageFile)));
  }
}
