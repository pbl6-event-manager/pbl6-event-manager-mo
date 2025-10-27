import "package:attendee/ui/common_widgets/common_text_field.dart";
import "package:attendee/utils/constants/app_string_constants.dart";
import "package:flutter/material.dart";

class AccountSettingFieldList extends StatelessWidget {
  const AccountSettingFieldList({
    super.key,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required this.email,
    required TextEditingController phoneController,
    required this.firstNameFocusNode,
    required this.lastNameFocusNode,
    required this.phoneFocusNode,
  }) : _firstNameController = firstNameController,
       _lastNameController = lastNameController,
       _phoneController = phoneController;

  final TextEditingController _firstNameController;
  final TextEditingController _lastNameController;
  final String? email;
  final TextEditingController _phoneController;

  final FocusNode firstNameFocusNode;
  final FocusNode lastNameFocusNode;
  final FocusNode phoneFocusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 28,
      children: [
        CommonTextField(
          focusNode: firstNameFocusNode,
          hintText: AppStringConstants.textFields.firstNamePlaceholder,
          controller: _firstNameController,
          keyboardType: TextInputType.name,
        ),
        CommonTextField(
          focusNode: lastNameFocusNode,
          hintText: AppStringConstants.textFields.lastNamePlaceholder,
          controller: _lastNameController,
          keyboardType: TextInputType.name,
        ),
        CommonTextField(
          hintText: AppStringConstants.textFields.emailPlaceholder,
          initialValue: email,
          isEnabled: false,
          keyboardType: TextInputType.emailAddress,
        ),
        CommonTextField(
          focusNode: phoneFocusNode,
          hintText: AppStringConstants.textFields.phoneNumberPlaceHolder,
          controller: _phoneController,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}
