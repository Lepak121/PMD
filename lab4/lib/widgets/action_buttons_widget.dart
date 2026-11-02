import 'package:flutter/material.dart';

/// Власний віджет: Блок кнопок дії зверху
class ActionButtonsWidget extends StatelessWidget {
  final String firstButtonText;
  final String secondButtonText;
  final VoidCallback onFirstPressed;
  final VoidCallback onSecondPressed;

  const ActionButtonsWidget({
    super.key,
    required this.firstButtonText,
    required this.secondButtonText,
    required this.onFirstPressed,
    required this.onSecondPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onFirstPressed,
            style: OutlinedButton.styleFrom(
              shape: const StadiumBorder(),
              side: BorderSide(
                color: theme.colorScheme.primary.withValues(alpha: 0.35),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              firstButtonText,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: OutlinedButton(
            onPressed: onSecondPressed,
            style: OutlinedButton.styleFrom(
              shape: const StadiumBorder(),
              side: BorderSide(
                color: theme.colorScheme.primary.withValues(alpha: 0.35),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              secondButtonText,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
