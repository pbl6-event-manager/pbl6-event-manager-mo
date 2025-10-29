import 'package:attendee/ui/common_widgets/common_text_field.dart';
import 'package:attendee/ui/scenes/unregistered/sign_up/bloc/sign_up_bloc.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpFieldList extends StatelessWidget {
  const SignUpFieldList({
    super.key,
    required this.initialEmail,
    required this.confirmEmailController,
    required this.firstNameController,
    required this.lastNameController,
    required this.passwordController,
    required this.confirmEmailFocusNode,
    required this.firstNameFocusNode,
    required this.lastNameFocusNode,
    required this.passwordFocusNode,
    required this.onPasswordSecuredButtonTapped,
  });
  final String initialEmail;

  final TextEditingController confirmEmailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController passwordController;

  final FocusNode confirmEmailFocusNode;
  final FocusNode firstNameFocusNode;
  final FocusNode lastNameFocusNode;
  final FocusNode passwordFocusNode;

  final VoidCallback onPasswordSecuredButtonTapped;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          spacing: 28,
          children: [
            CommonTextField(
              hintText: AppStringConstants.textFields.emailPlaceholder,
              initialValue: initialEmail,
              isReadOnly: true,
            ),
            CommonTextField(
              isEnabled: !state.isLoading,
              errorText: state.confirmEmailError,
              hintText: AppStringConstants.textFields.confirmEmailPlaceholder,
              controller: confirmEmailController,
              focusNode: confirmEmailFocusNode,
              keyboardType: TextInputType.emailAddress,
              onCompleted: () {
                firstNameFocusNode.requestFocus();
              },
              inputAction: TextInputAction.next,
            ),
            CommonTextField(
              isEnabled: !state.isLoading,
              errorText: state.firstNameError,
              hintText: AppStringConstants.textFields.firstNamePlaceholder,
              controller: firstNameController,
              focusNode: firstNameFocusNode,
              keyboardType: TextInputType.name,
              onCompleted: () {
                lastNameFocusNode.requestFocus();
              },
              inputAction: TextInputAction.next,
            ),
            CommonTextField(
              isEnabled: !state.isLoading,
              errorText: state.lastNameError,
              hintText: AppStringConstants.textFields.lastNamePlaceholder,
              controller: lastNameController,
              focusNode: lastNameFocusNode,
              keyboardType: TextInputType.name,
              onCompleted: () {
                passwordFocusNode.requestFocus();
              },
              inputAction: TextInputAction.next,
            ),
            CommonTextField(
              isEnabled: !state.isLoading,
              errorText: state.passwordError,
              focusNode: passwordFocusNode,
              hintText: AppStringConstants.textFields.passwordPlaceholder,
              controller: passwordController,
              onCompleted: () {
                FocusScope.of(context).unfocus();
              },
              onTrailingTapped: onPasswordSecuredButtonTapped,
              trailingIcon: Icon(
                state.isPasswordSecured
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              inputAction: TextInputAction.done,
              isSecured: state.isLoading == true
                  ? true
                  : state.isPasswordSecured,
            ),
          ],
        );
      },
    );
  }
}
