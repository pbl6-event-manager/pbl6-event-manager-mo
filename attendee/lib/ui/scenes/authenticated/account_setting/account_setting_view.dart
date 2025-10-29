import 'package:attendee/application/app_router.dart';
import 'package:attendee/domain/models/user.dart';
import 'package:attendee/ui/common_widgets/tappable_text_with_underline.dart';
import 'package:attendee/ui/scenes/authenticated/account_setting/account_setting_navigator.dart';
import 'package:attendee/ui/scenes/authenticated/account_setting/bloc/acccount_setting_bloc.dart';
import 'package:attendee/ui/scenes/authenticated/account_setting/enums/account_setting_picture_options.dart';
import 'package:attendee/ui/scenes/authenticated/account_setting/widgets/account_setting_avatar_widget.dart';
import 'package:attendee/ui/scenes/authenticated/account_setting/widgets/account_setting_field_list.dart';
import 'package:attendee/ui/scenes/authenticated/account_setting/widgets/account_setting_picture_options_modal.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class AccountSettingPage extends StatelessWidget {
  const AccountSettingPage({super.key, required this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountSettingBloc>(
          create: (context) => AccountSettingBloc(
            initialState: AccountSettingState.fromInitialData(
              firstName: user?.firstName,
              lastName: user?.lastName,
              phoneNumber: user?.phone,
            ),
          ),
        ),
        RepositoryProvider<AccountSettingNavigator>(
          create: (context) => AccountSettingNavigatorImplementation(
            goRouter: GetIt.instance<AppRouter>().router,
          ),
        ),
      ],
      child: AccountSettingView(user: user),
    );
  }
}

class AccountSettingView extends StatefulWidget {
  const AccountSettingView({super.key, required this.user});
  final User? user;

  @override
  State<AccountSettingView> createState() => _AccountSettingViewState();
}

class _AccountSettingViewState extends State<AccountSettingView> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;
  late final FocusNode _firstNameFocusNode;
  late final FocusNode _lastNameFocusNode;
  late final FocusNode _phoneFocusNode;

  String? get email => widget.user?.email;
  String? get firstName => widget.user?.firstName;
  String? get lastName => widget.user?.lastName;
  String? get phone => widget.user?.phone;
  String? get avatarUrl => widget.user?.avatarUrl;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: firstName ?? '');
    _lastNameController = TextEditingController(text: lastName ?? '');
    _phoneController = TextEditingController(text: phone ?? '');

    _firstNameController.addListener(
      () => _onFirstNameChanged(value: _firstNameController.text),
    );

    _lastNameController.addListener(
      () => _onLastNameChanged(value: _lastNameController.text),
    );

    _phoneController.addListener(
      () => _onPhoneNumberChanged(value: _phoneController.text),
    );

    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();

    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _onGoBackToPreviousScreen();
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: UIConstants.horizontalPadding,
          ),
          child: BlocBuilder<AccountSettingBloc, AccountSettingState>(
            builder: (context, state) {
              return ListView(
                padding: EdgeInsets.only(bottom: 40),
                children: [
                  AccountSettingAvatarWidget(
                    avatarUrl: avatarUrl,
                    firstName: firstName,
                    lastName: lastName,
                    selectedImage: state.selectedProfileImage,
                    onUpdatePictureTapped: () => onUpdatePictureTapped(
                      context,

                      onUpdatePictureOptionSelected:
                          _onUpdatePictureOptionSelected,
                    ),
                  ),
                  SizedBox(height: 32),
                  AccountSettingFieldList(
                    firstNameController: _firstNameController,
                    lastNameController: _lastNameController,
                    email: email,
                    phoneController: _phoneController,
                    firstNameFocusNode: _firstNameFocusNode,
                    lastNameFocusNode: _lastNameFocusNode,
                    phoneFocusNode: _phoneFocusNode,

                    firstNameValidationLabel: state.firstNameValidationLabel,
                    lastNameValidationLabel: state.lastNameValidationLabel,
                    phoneNumberValidatiionLabel:
                        state.phoneNumberValidationLabel,
                  ),
                  SizedBox(height: 32),
                  _buildChangePasswordTile(context),
                  SizedBox(height: 32),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: _buildClosePasswordUnderlineButton(context),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildClosePasswordUnderlineButton(BuildContext context) {
    return TappableTextWithUnderline(
      label: AppStringConstants.account.closeAccountLabel,
      style: context.textPalette.bodyMedium,
      onTapped: _onCloseAccountTapped,
    );
  }

  Widget _buildChangePasswordTile(BuildContext context) {
    return ListTile(
      title: Text(
        AppStringConstants.account.changePasswordLabel,
        style: context.textPalette.bodyLarge,
      ),
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.edit_outlined),
      trailing: Icon(Icons.chevron_right),
      onTap: _onEditPasswordTapped,
    );
  }

  void _onEditPasswordTapped() {
    final AccountSettingNavigator navigator = context
        .read<AccountSettingNavigator>();

    navigator.goToPassword();
  }

  void _onCloseAccountTapped() {}

  Future<AccountSettingPictureOptions?> onUpdatePictureTapped(
    BuildContext context, {
    required void Function(AccountSettingPictureOptions option)
    onUpdatePictureOptionSelected,
  }) async {
    return showModalBottomSheet<AccountSettingPictureOptions>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => AccountSettingPictureOptionsModal(
        onOptionSelected: onUpdatePictureOptionSelected,
      ),
    );
  }

  Future<void> _onUpdatePictureOptionSelected(
    AccountSettingPictureOptions option,
  ) async {
    final AccountSettingBloc bloc = context.read<AccountSettingBloc>();
    final ImagePicker picker = ImagePicker();

    switch (option) {
      case AccountSettingPictureOptions.takePhoto:
        final XFile? image = await picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          bloc.add(AccountProfilePictureChanged(imageFile: image));
        }
        break;

      case AccountSettingPictureOptions.chooseFromLibrary:
        final XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
        );
        if (image != null) {
          bloc.add(AccountProfilePictureChanged(imageFile: image));
        }
        break;

      case AccountSettingPictureOptions.delete:
        // Clear local selection and trigger deletion
        bloc.add(AccountProfilePictureChanged(imageFile: null));

        break;

      case AccountSettingPictureOptions.cancel:
        // Do nothing
        break;
    }
  }

  void _onFirstNameChanged({required String value}) {
    final AccountSettingBloc bloc = context.read<AccountSettingBloc>();

    bloc.add(AccountFirstNameFieldChanged(firstNameValue: value));
  }

  void _onLastNameChanged({required String value}) {
    final AccountSettingBloc bloc = context.read<AccountSettingBloc>();

    bloc.add(AccountLastNameFieldChanged(lastNameValue: value));
  }

  void _onPhoneNumberChanged({required String value}) {
    final AccountSettingBloc bloc = context.read<AccountSettingBloc>();

    bloc.add(AccountPhoneNumberFieldChanged(phoneNumberValue: value));
  }

  void _onGoBackToPreviousScreen() {
    final AccountSettingNavigator navigator = context
        .read<AccountSettingNavigator>();

    final AccountSettingState state = context.read<AccountSettingBloc>().state;

    navigator.goBackToAccount(
      firstName: state.firstNameValidationLabel == null
          ? state.changedFirstName
          : null,
      lastName: state.lastNameValidationLabel == null
          ? state.changedLastName
          : null,
      phoneNumber: state.phoneNumberValidationLabel == null
          ? state.changedPhoneNumber
          : null,
      profilePhoto: state.selectedProfileImage,
    );
  }
}
