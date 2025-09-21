import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/enums/password_strength_enum.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

class SignUpPasswordStrengthRow extends StatelessWidget {
  const SignUpPasswordStrengthRow({
    super.key,
    required PasswordStrengthEnum passwordStrength,
  }) : _passwordStrength = passwordStrength;

  final PasswordStrengthEnum _passwordStrength;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Flexible(
          flex: 2,
          child: Row(
            children: [
              Text(
                AppStringConstants.signUp.passwordStrengthLabel,
                style: context.textPalette.subtitleLarge,
              ),

              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  _passwordStrength.label,
                  style: context.textPalette.subtitleLarge,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 6),
        Flexible(
          flex: 1,
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(6),
            value: _passwordStrength.indicatorValue,
            backgroundColor: context.colorPalette.border,
            valueColor: AlwaysStoppedAnimation<Color>(
              _passwordStrength.getColor(context.colorPalette),
            ),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}
