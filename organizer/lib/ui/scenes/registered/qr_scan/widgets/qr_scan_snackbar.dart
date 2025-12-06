import 'package:flutter/material.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class QrScanSnackbar extends StatelessWidget {
  const QrScanSnackbar({
    super.key,
    required this.name,
    required String ticketType,
  }) : _isError = false,

       _secondaryText = ticketType;

  const QrScanSnackbar.error({
    super.key,
    required this.name,
    required String errorLabel,
  }) : _isError = true,
       _secondaryText = errorLabel;

  final bool _isError;
  final String name;
  final String _secondaryText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          color: _isError
              ? context.colorPalette.error
              : context.colorPalette.success,
          child: Center(
            child: _isError
                ? Icon(Icons.close, color: context.colorPalette.onError)
                : Icon(Icons.done, color: context.colorPalette.onSuccess),
          ),
        ),

        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 60,
            color: context.colorPalette.surfaceContainer,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,

                    style: context.textPalette.labelLarge.copyWith(
                      color: context.colorPalette.text,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    _secondaryText,
                    style: context.textPalette.caption.copyWith(
                      color: context.colorPalette.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
