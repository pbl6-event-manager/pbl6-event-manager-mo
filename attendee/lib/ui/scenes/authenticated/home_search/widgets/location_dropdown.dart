import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

class LocationDropdown extends StatelessWidget {
  const LocationDropdown({
    super.key,
    required this.hintText,
    required this.isLoading,
    required this.values,
    required this.onOptionSelected,
    this.value,
  });

  final String hintText;
  final bool isLoading;
  final List<String> values;
  final void Function(String? option) onOptionSelected;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: isLoading
          ? SizedBox(
              width: 10,
              height: 10,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(Icons.arrow_drop_down_outlined),
      initialValue: value,
      style: context.textPalette.labelLarge,
      isExpanded: true,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.colorPalette.border),
          borderRadius: BorderRadius.all(
            Radius.circular(UIConstants.cornerRadiusBase),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.colorPalette.divider),
          borderRadius: BorderRadius.all(
            Radius.circular(UIConstants.cornerRadiusBase),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.colorPalette.border),
          borderRadius: BorderRadius.all(
            Radius.circular(UIConstants.cornerRadiusBase),
          ),
        ),
      ),
      selectedItemBuilder: (context) => values
          .map(
            (value) => Align(
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: context.textPalette.bodyLarge,
              ),
            ),
          )
          .toList(),
      items: values
          .map(
            (value) => DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: context.textPalette.bodyLarge,
              ),
            ),
          )
          .toList(),
      onChanged: onOptionSelected,
    );
  }
}
