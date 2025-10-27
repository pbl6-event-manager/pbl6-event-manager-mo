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
  }) : _firstNameController = firstNameController,
       _lastNameController = lastNameController,
       _phoneController = phoneController;

  final TextEditingController _firstNameController;
  final TextEditingController _lastNameController;
  final String? email;
  final TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 28,
      children: [
        CommonTextField(
          hintText: AppStringConstants.textFields.firstNamePlaceholder,
          controller: _firstNameController,
          keyboardType: TextInputType.name,
          inputAction: TextInputAction.next,
        ),
        CommonTextField(
          hintText: AppStringConstants.textFields.lastNamePlaceholder,
          controller: _lastNameController,
          keyboardType: TextInputType.name,
          inputAction: TextInputAction.next,
        ),
        CommonTextField(
          hintText: AppStringConstants.textFields.emailPlaceholder,
          initialValue: email,
          isEnabled: false,
          keyboardType: TextInputType.emailAddress,
        ),
        CommonTextField(
          hintText: AppStringConstants.textFields.phoneNumberPlaceHolder,
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          inputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
