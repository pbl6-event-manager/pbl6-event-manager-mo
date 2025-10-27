import "package:attendee/ui/common_widgets/common_text_field.dart";
import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

class AccountSettingPasswordPage extends StatelessWidget {
  const AccountSettingPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AccountSettingPasswordView();
  }
}

class AccountSettingPasswordView extends StatefulWidget {
  const AccountSettingPasswordView({super.key});

  @override
  State<AccountSettingPasswordView> createState() =>
      _AccountSettingPasswordViewState();
}

class _AccountSettingPasswordViewState
    extends State<AccountSettingPasswordView> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _currentPasswordFocusNode = FocusNode();
  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _currentPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          CommonTextField(
            hintText: AppStringConstants.textFields.currentPasswordPlaceholder,
            controller: _currentPasswordController,
            focusNode: _currentPasswordFocusNode,
            isSecured: !_isCurrentPasswordVisible,
            trailingIcon: Icon(
              _isCurrentPasswordVisible
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: context.colorPalette.text,
            ),
            onTrailingTapped: () {
              setState(() {
                _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
              });
            },
            onCompleted: () {
              _newPasswordFocusNode.requestFocus();
            },
            inputAction: TextInputAction.next,
          ),
          SizedBox(height: 24),
          CommonTextField(
            hintText: AppStringConstants.textFields.newPasswordPlaceholder,
            controller: _newPasswordController,
            focusNode: _newPasswordFocusNode,
            isSecured: !_isNewPasswordVisible,
            trailingIcon: Icon(
              _isNewPasswordVisible ? Icons.visibility_off : Icons.visibility,
              color: context.colorPalette.text,
            ),
            onTrailingTapped: () {
              setState(() {
                _isNewPasswordVisible = !_isNewPasswordVisible;
              });
            },
            onCompleted: () {
              _confirmPasswordFocusNode.requestFocus();
            },
            inputAction: TextInputAction.next,
          ),
          SizedBox(height: 8),
          Text(
            AppStringConstants.textFields.passwordValidationError,
            style: context.textPalette.subtitleLarge,
          ),
          SizedBox(height: 24),
          CommonTextField(
            hintText: AppStringConstants.textFields.confirmPasswordPlaceholder,
            controller: _confirmPasswordController,
            focusNode: _confirmPasswordFocusNode,
            isSecured: !_isConfirmPasswordVisible,
            trailingIcon: Icon(
              _isConfirmPasswordVisible
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: context.colorPalette.text,
            ),
            onTrailingTapped: () {
              setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              });
            },
            inputAction: TextInputAction.done,
          ),
          SizedBox(height: 8),
          Text(
            AppStringConstants.textFields.passwordValidationError,
            style: context.textPalette.subtitleLarge,
          ),

          SizedBox(height: 16),

          FilledButton(
            onPressed: _onUpdatePasswordTapped,
            child: Text("Update password"),
          ),
        ],
      ),
    );
  }

  void _onUpdatePasswordTapped() {}
}
