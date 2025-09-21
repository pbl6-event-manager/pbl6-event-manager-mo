import "package:attendee/ui/common_widgets/common_button_with_loading.dart";
import "package:attendee/ui/scenes/unregistered/sign_up/bloc/sign_up_bloc.dart";
import "package:attendee/utils/constants/app_string_constants.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class SignUpSubmitButton extends StatelessWidget {
  const SignUpSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return CommonButtonWithLoading(
          label: AppStringConstants.signUp.signUpLabel,
          isEnabled: state.isFormValid,
          isLoading: state.isLoading,
          onPressed: () => context.read<SignUpBloc>().add(SubmitButtonTapped()),
        );
      },
    );
  }
}
