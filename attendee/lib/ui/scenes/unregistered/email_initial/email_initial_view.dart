import "package:attendee/ui/common_widgets/common_text_field.dart";
import "package:attendee/ui/common_widgets/common_button_with_loading.dart";
import "package:attendee/ui/scenes/unregistered/email_initial/email_initial_navigator.dart";
import "package:attendee/ui/scenes/unregistered/email_initial/widgets/email_address_banner_widget.dart";
import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/enums/view_status_enum.dart";

import "package:attendee/utils/extensions/context_extension.dart";
import "package:attendee/ui/scenes/unregistered/email_initial/bloc/email_initial_bloc.dart";
import "package:attendee/ui/scenes/unregistered/email_initial/bloc/email_initial_event.dart";
import "package:attendee/ui/scenes/unregistered/email_initial/bloc/email_initial_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";

class EmailInitialPage extends StatelessWidget {
  const EmailInitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EmailInitialBloc()),
        BlocProvider(
          create: (context) => EmailInitialNavigatorImplementation(
            goRouter: GoRouter.of(context),
          ),
        ),
      ],
      child: EmailInitialView(),
    );
  }
}

class EmailInitialView extends StatefulWidget {
  const EmailInitialView({super.key});

  @override
  State<EmailInitialView> createState() => _EmailInitialViewState();
}

class _EmailInitialViewState extends State<EmailInitialView> {
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    emailController.addListener(() {
      context.read<EmailInitialBloc>().add(EmailChanged(emailController.text));
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EmailInitialBloc bloc = context.read<EmailInitialBloc>();
    return BlocListener<EmailInitialBloc, EmailInitialState>(
      listener: (context, state) => _blocListener(context, state),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.only(
            left: UIConstants.safeAreaHorizontal,
            right: UIConstants.safeAreaHorizontal,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStringConstants.emailInitial.title,
                        style: context.textPalette.displayLarge,
                      ),
                      SizedBox(height: 26),
                      BlocBuilder<EmailInitialBloc, EmailInitialState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              CommonTextField(
                                keyboardType: TextInputType.emailAddress,
                                onCompleted: () => bloc.add(EmailCompleted()),
                                hintText: AppStringConstants
                                    .textFields
                                    .emailPlaceholder,
                                controller: emailController,
                                errorText: state.emailError,
                              ),
                              if (state.emailError == null)
                                SizedBox(height: 26),
                            ],
                          );
                        },
                      ),

                      EmailAddressBannerWidget(),
                    ],
                  ),
                ),
              ),
              BlocBuilder<EmailInitialBloc, EmailInitialState>(
                builder: (context, state) {
                  return CommonButtonWithLoading(
                    label: AppStringConstants.buttons.nextLabel,
                    isEnabled: state.isButtonEnabled,
                    isLoading: state.isLoading,
                    onPressed: () => bloc.add(EmailSubmitted()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _blocListener(BuildContext context, EmailInitialState state) {
    if (state.status == ViewStatusEnum.success) {
      context.read<EmailInitialNavigatorImplementation>().goToSignIn(
        email: emailController.text,
      );
    }
  }
}
