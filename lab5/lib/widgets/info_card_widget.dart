import 'package:flutter/material.dart';

/// Власний віджет: Інформаційна картка з описом, перемикачем та TextField
class InfoCardWidget extends StatelessWidget {
  final String mainDescription;
  final String studentNote;
  final bool showExtraDetails;
  final ValueChanged<bool> onToggleExtraDetails;
  final String userNote;
  final ValueChanged<String> onNoteChanged;

  const InfoCardWidget({
    super.key,
    required this.mainDescription,
    required this.studentNote,
    required this.showExtraDetails,
    required this.onToggleExtraDetails,
    required this.userNote,
    required this.onNoteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Основний текст опису
        Text(
          mainDescription,
          style: const TextStyle(
            fontSize: 14,
            height: 1.4,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),

        // 3. Switch: змінює відображення (показ/приховування тексту, поява бейджа, зміна стилю)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: showExtraDetails ? Colors.blue.shade50 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Детальні характеристики',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: showExtraDetails ? Colors.blue.shade900 : Colors.black87,
                  ),
                ),
              ),
              Switch(
                value: showExtraDetails,
                onChanged: onToggleExtraDetails,
              ),
            ],
          ),
        ),

        // Показ/приховування тексту та зміна стилю за допомогою Switch
        if (showExtraDetails) ...[
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: const Text(
              '• Двигун: 2.0 TFSI (245 к.с.)\n'
              '• Привід: Повний (Quattro)\n'
              '• Колір: Чорний металік (Mythos Black)',
              style: TextStyle(
                fontSize: 13,
                height: 1.35,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ],

        const SizedBox(height: 10),

        // 4. TextField: зчитує введений текст через onChanged
        TextField(
          onChanged: onNoteChanged,
          decoration: InputDecoration(
            labelText: 'Ваша замітка до авто',
            hintText: 'Введіть коментар або питання...',
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.edit_note),
          ),
        ),

        // Відображення результату введення нижче
        if (userNote.isNotEmpty) ...[
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.shade300),
            ),
            child: Text(
              'Збережена замітка: $userNote',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.amber.shade900,
              ),
            ),
          ),
        ],

        const SizedBox(height: 6),
        Text(
          studentNote,
          style: const TextStyle(
            fontSize: 12,
            height: 1.3,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
