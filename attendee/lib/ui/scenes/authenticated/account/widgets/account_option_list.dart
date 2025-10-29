import 'package:attendee/ui/scenes/authenticated/account/enums/account_options.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class AccountOptionList<T extends AccountOptions> extends StatelessWidget {
  const AccountOptionList({
    super.key,
    required this.options,
    required this.onOptionTapped,
  });

  final List<T> options;
  final void Function(T selectedOption) onOptionTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ListTile.divideTiles(
        color: context.colorPalette.divider,
        tiles: options.map(
          (option) => ListTile(
            leading: Icon(option.icon),
            title: Text(option.title, style: context.textPalette.bodyLarge),
            onTap: () => onOptionTapped(option),
            contentPadding: EdgeInsets.zero,
            trailing: Icon(Icons.chevron_right_outlined),
          ),
        ),
      ).toList(),
    );
  }
}
