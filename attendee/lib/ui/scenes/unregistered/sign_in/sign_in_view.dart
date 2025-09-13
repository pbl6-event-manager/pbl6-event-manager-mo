import 'package:attendee/application/bloc/auth_bloc.dart';
import 'package:attendee/ui/common_widgets/common_button_with_loading.dart';
import 'package:attendee/ui/common_widgets/common_text_field.dart';
import 'package:attendee/ui/common_widgets/circular_avatar.dart';
import 'package:attendee/ui/common_widgets/tappable_text_with_underline.dart';
import 'package:attendee/ui/scenes/unregistered/sign_in/bloc/sign_in_bloc.dart';
import 'package:attendee/ui/scenes/unregistered/sign_in/bloc/sign_in_event.dart';
import 'package:attendee/ui/scenes/unregistered/sign_in/bloc/sign_in_state.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(authBloc: context.read<AuthBloc>()),

      // TODO: Call API to get image here
      child: SignInView(email: email, imageUrl: "null"),
    );
  }
}

class SignInView extends StatefulWidget {
  const SignInView({super.key, required this.email, required this.imageUrl});
  final String email;
  final String? imageUrl;

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    passwordController.addListener(
      () => context.read<SignInBloc>().add(
        PasswordChanged(passwordController.text),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SignInBloc bloc = context.read<SignInBloc>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          left: UIConstants.safeAreaHorizontal,
          right: UIConstants.safeAreaHorizontal,
          bottom: 16,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    CircularAvatar(url: widget.imageUrl),
                    SizedBox(height: 12),
                    Text(widget.email, style: context.textPalette.labelLarge),
                    SizedBox(height: 12),
                    TappableTextWithUnderline(
                      label: AppStringConstants.signIn.changeLabel,
                      onTapped: () {},
                    ),
                    SizedBox(height: 36),
                    _buildTextField(bloc),
                    SizedBox(height: 18),
                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: TappableTextWithUnderline(
                        label: AppStringConstants.signIn.forgotPasswordLabel,
                        onTapped: () {},
                        style: context.textPalette.bodyLarge.copyWith(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [_buildButton(bloc)],
            ),
          ],
        ),
      ),
    );
  }

  BlocBuilder<SignInBloc, SignInState> _buildTextField(SignInBloc bloc) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return CommonTextField(
          hintText: AppStringConstants.textFields.passwordPlaceholder,
          controller: passwordController,
          trailingIcon: Icon(
            state.isSecured ? Icons.visibility_off : Icons.visibility,
          ),
          isSecured: state.isSecured,
          isEnabled: !state.isLoading,
          errorText: state.passwordError,
          onTrailingTapped: () => bloc.add(PasswordSecuredButtonTapped()),
        );
      },
    );
  }

  Widget _buildButton(SignInBloc bloc) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return CommonButtonWithLoading(
          label: AppStringConstants.signIn.signInLabel,
          isEnabled: state.isButtonEnabled,
          isLoading: state.isLoading,
          onPressed: () => bloc.add(PasswordSubmitted()),
        );
      },
    );
  }
}
