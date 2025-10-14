import "package:attendee/application/bloc/auth_bloc.dart";
import "package:attendee/domain/repositories/auth_repository.dart";
import "package:attendee/ui/common_widgets/mix_text.dart";
import "package:attendee/ui/scenes/unregistered/sign_up/bloc/sign_up_bloc.dart";
import "package:attendee/ui/scenes/unregistered/sign_up/widgets/sign_up_field_list.dart";
import "package:attendee/ui/scenes/unregistered/sign_up/widgets/sign_up_password_strength_row.dart";
import "package:attendee/ui/scenes/unregistered/sign_up/widgets/sign_up_submit_button.dart";
import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/enums/password_strength_enum.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:attendee/utils/string_utils.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        originalEmail: email,
        authBloc: context.read<AuthBloc>(),
        repository: GetIt.instance<AuthRepository>(),
      ),
      child: SignUpView(email: email),
    );
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({super.key, required this.email});
  final String email;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late final TextEditingController _confirmEmailController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _passwordController;

  final FocusNode _confirmEmailFocusNode = FocusNode();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  PasswordStrengthEnum _passwordStrength = PasswordStrengthEnum.none;
  bool _showPasswordStrength = false;

  @override
  void initState() {
    super.initState();

    _passwordController = TextEditingController();
    _confirmEmailController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();

    _addTextEditingListenners(bloc: context.read<SignUpBloc>());
    _addFocusNodeListenners(bloc: context.read<SignUpBloc>());

    _passwordFocusNode.addListener(_onPasswordFocusChanged);
    _passwordController.addListener(_showPasswordStrengthIndicator);
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmEmailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();

    _confirmEmailFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          left: UIConstants.horizontalPadding,
          right: UIConstants.horizontalPadding,
          bottom: 16,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text(
                    AppStringConstants.signUp.title,
                    style: context.textPalette.displayLarge,
                  ),
                  SizedBox(height: 26),

                  SignUpFieldList(
                    initialEmail: widget.email,
                    confirmEmailController: _confirmEmailController,
                    firstNameController: _firstNameController,
                    lastNameController: _lastNameController,
                    passwordController: _passwordController,
                    confirmEmailFocusNode: _confirmEmailFocusNode,
                    firstNameFocusNode: _firstNameFocusNode,
                    lastNameFocusNode: _lastNameFocusNode,
                    passwordFocusNode: _passwordFocusNode,

                    onPasswordSecuredButtonTapped: () => context
                        .read<SignUpBloc>()
                        .add(PasswordSecuredButtonTapped()),
                  ),

                  if (_showPasswordStrength) ...[
                    SizedBox(height: 32),
                    SignUpPasswordStrengthRow(
                      passwordStrength: _passwordStrength,
                    ),
                  ],
                  SizedBox(height: 12),
                  MixText(
                    text: AppStringConstants.signUp.policiesAndTermsLabel,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [SignUpSubmitButton()],
            ),
          ],
        ),
      ),
    );
  }

  void _showPasswordStrengthIndicator() {
    setState(() {
      _passwordStrength = StringUtils.calculatePasswordStrength(
        _passwordController.text,
      );
    });
  }

  void _onPasswordFocusChanged() {
    setState(() {
      _showPasswordStrength = _passwordFocusNode.hasFocus;
    });
  }

  void _addTextEditingListenners({required SignUpBloc bloc}) {
    _confirmEmailController.addListener(
      () => bloc.add(
        FieldChanged(_confirmEmailController.text, SignUpFields.confirmEmail),
      ),
    );

    _firstNameController.addListener(
      () => bloc.add(
        FieldChanged(_firstNameController.text, SignUpFields.firstName),
      ),
    );

    _lastNameController.addListener(
      () => bloc.add(
        FieldChanged(_lastNameController.text, SignUpFields.lastName),
      ),
    );
    _passwordController.addListener(
      () => bloc.add(
        FieldChanged(_passwordController.text, SignUpFields.password),
      ),
    );
  }

  void _addFocusNodeListenners({required SignUpBloc bloc}) {
    _confirmEmailFocusNode.addListener(() {
      if (!_confirmEmailFocusNode.hasFocus) {
        bloc.add(FieldCompleted(SignUpFields.confirmEmail));
      }
    });

    _firstNameFocusNode.addListener(() {
      if (!_firstNameFocusNode.hasFocus) {
        bloc.add(FieldCompleted(SignUpFields.firstName));
      }
    });

    _lastNameFocusNode.addListener(() {
      if (!_lastNameFocusNode.hasFocus) {
        bloc.add(FieldCompleted(SignUpFields.lastName));
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        bloc.add(FieldCompleted(SignUpFields.password));
      }
    });
  }
}
