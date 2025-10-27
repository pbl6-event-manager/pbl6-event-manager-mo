import "package:attendee/domain/models/user.dart";
import "package:attendee/ui/common_widgets/tappable_text_with_underline.dart";
import "package:attendee/ui/scenes/authenticated/account_setting/widgets/account_setting_avatar_widget.dart";
import "package:attendee/ui/scenes/authenticated/account_setting/widgets/account_setting_field_list.dart";
import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

class AccountSettingPage extends StatelessWidget {
  const AccountSettingPage({super.key, required this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    return AccountSettingView(user: user);
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

  String? get email => widget.user?.email;
  String? get firstName => widget.user?.firstName;
  String? get lastName => widget.user?.lastName;
  String? get phone => widget.user?.phone;
  String? get avatarUrl => widget.user?.avatarUrl;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: firstName ?? "");
    _lastNameController = TextEditingController(text: lastName ?? "");
    _phoneController = TextEditingController(text: phone ?? "");
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: UIConstants.horizontalPadding,
        ),
        child: ListView(
          padding: EdgeInsets.only(bottom: 40),
          children: [
            AccountSettingAvatarWidget(
              avatarUrl: avatarUrl,
              firstName: firstName,
              lastName: lastName,
            ),
            SizedBox(height: 32),
            AccountSettingFieldList(
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
              email: email,
              phoneController: _phoneController,
            ),
            SizedBox(height: 32),
            _buildChangePasswordTile(context),
            SizedBox(height: 32),
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: _buildClosePasswordUnderlineButton(context),
            ),
          ],
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

  void _onEditPasswordTapped() {}

  void _onCloseAccountTapped() {}
}
