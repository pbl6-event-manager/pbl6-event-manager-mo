import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:organizer/application/bloc/auth_bloc.dart';
import 'package:organizer/domain/repositories/auth_repository.dart';
import 'package:organizer/ui/common_widgets/common_text_field.dart';
import 'package:organizer/ui/scenes/unregistered/sign_in/bloc/sign_in_bloc.dart';
import 'package:organizer/ui/scenes/unregistered/sign_in/widgets/error_banner.dart';
import 'package:organizer/ui/scenes/unregistered/sign_in/widgets/sign_in_button.dart';
import 'package:organizer/utils/constants/asset_constant.dart';
import 'package:organizer/utils/constants/app_string_constant.dart';
import 'package:organizer/utils/enums/view_status.dart';
import 'package:organizer/utils/extensions/context_extension.dart';
import 'package:organizer/utils/validation_util.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(
        authBloc: context.read<AuthBloc>(),
        repository: GetIt.instance<AuthRepository>(),
      ),
      child: const SignInView(),
    );
  }
}

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool _isSubmitEnabled = false;
  bool _isSecured = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.addListener(() => _onFormChanged());
    _passwordController.addListener(() => _onFormChanged());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 46),
          child: BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              return Column(
                children: [
                  Image.asset(AssetConstant.eventbriteLogo, width: 200),

                  // Only show when there is error
                  if (state.errorMessage != null) ...[
                    ErrorBanner(message: state.errorMessage ?? ''),
                    SizedBox(height: 16),
                  ],
                  Column(
                    children: [
                      CommonTextField(
                        controller: _emailController,
                        validator: ValidationUtils.validateEmail,
                        hintText: AppStringConstant.signIn.emailHint,
                        label: AppStringConstant.signIn.emailLabel,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16),
                      CommonTextField(
                        controller: _passwordController,
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

                  SizedBox(height: 32),
                  SignInButton(
                    isLoading: state.status == ViewStatus.loading,
                    onTapped:
                        _isSubmitEnabled && state.status != ViewStatus.loading
                        ? _onSubmitTapped
                        : null,
                  ),

                  SizedBox(height: 46),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _onFormChanged() {
    setState(() {
      _isSubmitEnabled =
          ValidationUtils.validateEmail(_emailController.text) == null &&
          ValidationUtils.validateGeneralField(_passwordController.text) ==
              null;
    });

    log(_isSubmitEnabled.toString());
  }

  void _onPasswordSecuredTapped() {
    setState(() {
      _isSecured = !_isSecured;
    });
  }

  void _onSubmitTapped() {
    final SignInBloc bloc = context.read<SignInBloc>();
    bloc.add(
      SignInSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
