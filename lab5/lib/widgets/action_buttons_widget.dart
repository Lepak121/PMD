import 'package:flutter/material.dart';

/// Власний віджет: Блок кнопок дії
class ActionButtonsWidget extends StatelessWidget {
  final String firstButtonText;
  final String secondButtonText;
  final int counter;
  final VoidCallback onFirstPressed;
  final VoidCallback onSecondPressed;

  const ActionButtonsWidget({
    super.key,
    required this.firstButtonText,
    required this.secondButtonText,
    required this.counter,
    required this.onFirstPressed,
    required this.onSecondPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        // 1. Кнопка дії, що збільшує лічильник та відображає поточне значення
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onFirstPressed,
            icon: const Icon(Icons.touch_app, size: 18),
            style: OutlinedButton.styleFrom(
              shape: const StadiumBorder(),
              side: BorderSide(
                color: theme.colorScheme.primary.withValues(alpha: 0.5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            label: Text(
              '$firstButtonText ($counter)',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // 2. Друга кнопка дії
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
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
