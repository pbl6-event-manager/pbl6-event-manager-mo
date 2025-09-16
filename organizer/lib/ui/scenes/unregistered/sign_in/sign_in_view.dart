import 'package:flutter/material.dart';
import 'package:organizer/ui/common_widgets/common_text_field.dart';
import 'package:organizer/ui/scenes/unregistered/sign_in/widgets/error_banner.dart';
import 'package:organizer/ui/scenes/unregistered/sign_in/widgets/sign_in_button.dart';
import 'package:organizer/utils/constants/asset_constant.dart';
import 'package:organizer/utils/constants/app_string_constant.dart';
import 'package:organizer/utils/extensions/context_extension.dart';
import 'package:organizer/utils/validation_util.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SignInView();
  }
}

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();

  bool _isSubmitEnabled = false;
  bool _isSecured = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 46),
          child: Column(
            children: [
              Image.asset(AssetConstant.eventbriteLogo, width: 200),

              // Only show when there is error
              // TODO: Add real error here
              ErrorBanner(message: AppStringConstant.signIn.errorBanner),

              SizedBox(height: 16),

              Form(
                onChanged: _onFormChanged,
                autovalidateMode: AutovalidateMode.onUnfocus,
                key: _formKey,
                child: Column(
                  children: [
                    CommonTextField(
                      validator: ValidationUtils.validateEmail,
                      hintText: AppStringConstant.signIn.emailHint,
                      label: AppStringConstant.signIn.emailLabel,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16),
                    CommonTextField(
                      validator: ValidationUtils.validateGeneralField,
                      hintText: AppStringConstant.signIn.passwordHint,
                      label: AppStringConstant.signIn.passwordLabel,
                      isSecured: _isSecured,
                      onSuffixTapped: _onPasswordSecuredTapped,

                      suffixAction: Text(
                        _isSecured
                            ? AppStringConstant.signIn.passwordToggleShow
                            : AppStringConstant.signIn.passwordToggleHide,
                        style: context.textPalette.labelLarge.copyWith(
                          color: context.colorPalette.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32),
              SignInButton(
                isLoading: false,
                onTapped: _isSubmitEnabled ? _onSubmitTapped : null,
              ),

              SizedBox(height: 46),
            ],
          ),
        ),
      ),
    );
  }

  void _onFormChanged() {
    setState(() {
      _isSubmitEnabled = _formKey.currentState!.validate();
    });
  }

  void _onPasswordSecuredTapped() {
    setState(() {
      _isSecured = !_isSecured;
    });
  }

  void _onSubmitTapped() {}
}
