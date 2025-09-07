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
    required this.controller,
    this.keyboardType = TextInputType.text,

    this.errorText,
    this.onCompleted,
    this.enabled = true,
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  final String? errorText;
  final VoidCallback? onCompleted;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final bool hasError = errorText != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 56),
          decoration: BoxDecoration(
            color: context.colorPalette.surfaceContainer,
            border: Border.all(
              color: hasError
                  ? context.colorPalette.error
                  : context.colorPalette.border,
            ),
            borderRadius: BorderRadius.circular(UIConstants.textFieldRadius),
          ),
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildHintLabel(hasError), _buildTextField(context)],
          ),
        ),
        if (errorText != null) ...[_buildErrorValidationLabel(context)],
      ],
    );
  }

  FormField<Object?> _buildTextField(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      onEditingComplete: () {
        if (onCompleted != null) {
          onCompleted!();
        }
        FocusScope.of(context).unfocus();
      },
      keyboardType: keyboardType,

      onTapUpOutside: (_) => FocusScope.of(context).unfocus(),
      controller: controller,
      decoration: InputDecoration.collapsed(
        hintText: hintText,
        hintStyle: context.textPalette.bodyLarge.copyWith(
          color: context.colorPalette.textPlaceholder,
        ),
      ),
      style: context.textPalette.labelLarge,
    );
  }

  Widget _buildHintLabel(bool hasError) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return AnimatedSize(
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 200),
          child: value.text.isNotEmpty
              ? Text(
                  hintText,
                  style: context.textPalette.subtitleLarge.copyWith(
                    color: hasError
                        ? context.colorPalette.error
                        : context.colorPalette.textPlaceholder,
                  ),
                )
              : SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildErrorValidationLabel(BuildContext context) {
    return SizedBox(
      height: 26,
      child: Row(
        spacing: 2,
        children: [
          Icon(Icons.error, size: 13, color: context.colorPalette.error),
          Text(
            errorText!,
            style: context.textPalette.bodyLarge.copyWith(
              color: context.colorPalette.error,
            ),
          ),
        ],
      ),
    );
  }
}
