import "package:attendee/ui/themes/color_palette.dart";
import "package:attendee/ui/themes/text_palette.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

/// Text field with placeholder labels automatically moves up without also hiding the border
///
/// Validation supported through [errorText] property,
/// if is not null then show validation error
class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.initialValue,
    this.errorText,
    this.onCompleted,
    this.isEnabled = true,
    this.isSecured = false,
    this.isReadOnly = false,
    this.trailingIcon,
    this.onTrailingTapped,
    this.focusNode,
    this.inputAction = TextInputAction.done,
  });

  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction inputAction;

  final String? errorText;

  /// Called when user tapped "Done" on keyboard
  final VoidCallback? onCompleted;
  final bool isEnabled;
  final bool isSecured;
  final bool isReadOnly;

  final Widget? trailingIcon;
  final VoidCallback? onTrailingTapped;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    final bool isErrorState = errorText != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 56),
          decoration: BoxDecoration(
            color: context.colorPalette.surfaceContainer,
            border: Border.all(
              color: isErrorState
                  ? context.colorPalette.error
                  : context.colorPalette.border,
            ),
            borderRadius: BorderRadius.circular(UIConstants.textFieldRadius),
          ),
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller != null)
                _buildHintLabelWithListenable(
                  isErrorState,
                  controller: controller!,
                )
              else
                _buildSmallHintText(
                  context.textPalette,
                  context.colorPalette,
                  isHidden: initialValue != null,
                  hintText: hintText,
                ),

              _buildTextField(context),
            ],
          ),
        ),
        if (isErrorState) _buildErrorValidationLabel(context),
      ],
    );
  }

  Widget _buildTextField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            textInputAction: inputAction,
            focusNode: focusNode,
            readOnly: isReadOnly,

            initialValue: controller == null ? initialValue : null,
            obscureText: isSecured,
            enabled: isEnabled,
            onEditingComplete: () {
              if (onCompleted != null) {
                onCompleted!();
              } else {
                focusNode?.unfocus();
              }
            },
            keyboardType: keyboardType,
            onTapUpOutside: (_) => () {
              if (onCompleted != null) {
                onCompleted!();
              } else {
                focusNode?.unfocus();
              }
            },
            controller: controller,
            decoration: InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: context.textPalette.bodyLarge.copyWith(
                color: context.colorPalette.textPlaceholder,
              ),
            ),
            style: context.textPalette.labelLarge,
          ),
        ),
        if (trailingIcon != null)
          GestureDetector(
            onTap: isEnabled ? onTrailingTapped : null,
            child: trailingIcon,
          ),
      ],
    );
  }

  Widget _buildHintLabelWithListenable(
    bool hasError, {
    required TextEditingController controller,
  }) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return AnimatedSize(
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 200),
          child: _buildSmallHintText(
            context.textPalette,
            context.colorPalette,
            isHidden: value.text.isNotEmpty,
            hintText: hintText,
          ),
        );
      },
    );
  }

  Widget _buildSmallHintText(
    TextPalette textPalette,
    ColorPalette colorPalette, {
    required bool isHidden,
    required String hintText,
    bool hasError = false,
  }) => isHidden
      ? Text(
          hintText,
          style: textPalette.subtitleLarge.copyWith(
            color: hasError ? colorPalette.error : colorPalette.textPlaceholder,
          ),
        )
      : SizedBox.shrink();

  Widget _buildErrorValidationLabel(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,

        spacing: 2,
        children: [
          Icon(Icons.error, size: 13, color: context.colorPalette.error),
          Flexible(
            child: Text(
              errorText!,
              style: context.textPalette.bodyLarge.copyWith(
                color: context.colorPalette.error,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
