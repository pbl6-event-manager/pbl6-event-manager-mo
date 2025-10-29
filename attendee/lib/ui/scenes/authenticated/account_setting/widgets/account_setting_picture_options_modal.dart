import 'package:attendee/ui/scenes/authenticated/account_setting/enums/account_setting_picture_options.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class AccountSettingPictureOptionsModal extends StatelessWidget {
  const AccountSettingPictureOptionsModal({
    super.key,
    required this.onOptionSelected,
  });

  final Function(AccountSettingPictureOptions) onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(height: 0),
        itemBuilder: (context, index) =>
            _buildOption(context, AccountSettingPictureOptions.values[index]),

        itemCount: AccountSettingPictureOptions.values.length,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 16),
        shrinkWrap: true,
      ),
    );
  }

  Widget _buildOption(
    BuildContext context,
    AccountSettingPictureOptions option,
  ) {
    final bool isDestructive = option == AccountSettingPictureOptions.delete;
    final bool isCancel = option == AccountSettingPictureOptions.cancel;

    return InkWell(
      onTap: () {
        Navigator.of(context).pop(option);
        onOptionSelected(option);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Text(
          option.label,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: context.textPalette.bodyLarge.copyWith(
            color: isDestructive
                ? context.colorPalette.error
                : isCancel
                ? context.colorPalette.textPlaceholder
                : context.colorPalette.text,
            fontWeight: isCancel ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
