import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

class HomeSearchListTile extends StatelessWidget {
  const HomeSearchListTile({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.onClearTapped,
    required this.onTapped,
  });

  const HomeSearchListTile.recent({
    super.key,
    required this.label,
    required this.onClearTapped,
    required this.onTapped,
  }) : prefixIcon = Icons.history;

  const HomeSearchListTile.search({
    super.key,
    required this.label,
    required this.onTapped,
  }) : prefixIcon = Icons.search,
       onClearTapped = null;

  const HomeSearchListTile.location({
    super.key,
    required this.label,
    required this.onTapped,
  }) : prefixIcon = Icons.location_on_outlined,
       onClearTapped = null;

  final String label;
  final IconData prefixIcon;
  final VoidCallback? onClearTapped;
  final VoidCallback? onTapped;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTapped,
      title: Text(
        label,
        style: context.textPalette.bodyLarge.copyWith(fontSize: 16),
      ),
      leading: Icon(prefixIcon),
      trailing: onClearTapped != null
          ? IconButton(
              onPressed: onClearTapped,
              icon: Icon(Icons.cancel_outlined),
            )
          : null,
      contentPadding: EdgeInsets.zero,
    );
  }
}
