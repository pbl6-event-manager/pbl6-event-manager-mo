import 'package:flutter/material.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    this.hintText,
    this.label,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.suffixAction,
    this.onSuffixTapped,
    this.isSecured = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  });

  final String? hintText;
  final String? label;
  final String? initialValue;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? suffixAction;
  final VoidCallback? onSuffixTapped;

  final bool isSecured;

  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      style: context.textPalette.bodyLarge,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: isSecured,
      decoration: InputDecoration(
        suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),

        errorStyle: context.textPalette.labelSmall.copyWith(
          color: context.colorPalette.error,
        ),

        suffixIcon: (suffixAction != null)
            ? InkWell(onTap: onSuffixTapped, child: suffixAction)
            : null,
        label: (label != null)
            ? Text(
                label ?? '',
                style: context.textPalette.labelLarge.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              )
            : null,
      ),
    );
  }
}
