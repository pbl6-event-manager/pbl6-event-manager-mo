import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class FocusAwareTextField extends StatefulWidget {
  const FocusAwareTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.initialValue,
    this.onChanged,
    this.onFocusChanged,
    this.isEnabled = true,
  });

  final String? hintText;
  final IconData? prefixIcon;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onFocusChanged;
  final bool isEnabled;

  @override
  State<FocusAwareTextField> createState() => FocusAwareTextFieldState();
}

class FocusAwareTextFieldState extends State<FocusAwareTextField> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      widget.onFocusChanged?.call(_focusNode.hasFocus);
    });
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FocusAwareTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final String newText = widget.initialValue ?? '';
    if (_controller.text != newText) {
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isFocused = _focusNode.hasFocus;
    final Color fillColor = isFocused
        ? context.colorPalette.surfaceContainer
        : context.colorPalette.surface;
    final Color borderColor = isFocused
        ? context.colorPalette.primary
        : context.colorPalette.border;
    final Color iconColor = isFocused
        ? context.colorPalette.primary
        : context.colorPalette.textPlaceholder;

    return TextFormField(
      enabled: widget.isEnabled,
      controller: _controller,
      style: context.textPalette.bodyLarge,
      focusNode: _focusNode,
      cursorColor: context.colorPalette.primary,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, size: 24, color: iconColor)
            : null,
        hintText: widget.hintText,
        hintStyle: context.textPalette.bodyLarge.copyWith(
          color: context.colorPalette.textPlaceholder,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: context.colorPalette.border),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
      ),
    );
  }
}
