import 'package:flutter/material.dart';

/// Власний віджет: Інформаційна картка або текстовий блок опису
class InfoCardWidget extends StatelessWidget {
  final String mainDescription;
  final String studentNote;

  const InfoCardWidget({
    super.key,
    required this.mainDescription,
    required this.studentNote,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mainDescription,
          style: const TextStyle(
            fontSize: 15,
            height: 1.45,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          studentNote,
          style: const TextStyle(
            fontSize: 14,
            height: 1.4,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
        // Spacer забезпечує адаптивний розподіл вільного простору
        const Spacer(),
      ],
    );
  }
}
