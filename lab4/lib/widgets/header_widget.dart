import 'package:flutter/material.dart';

/// Власний віджет: Заголовок або верхній інформаційний блок
/// Містить інтерактивну іконку "обране" (bool) та бейдж (керований через Switch/Checkbox)
class HeaderWidget extends StatelessWidget {
  final String title;
  final String category;
  final bool isFavorite;
  final bool showBadge;
  final VoidCallback onFavoriteToggle;

  const HeaderWidget({
    super.key,
    required this.title,
    required this.category,
    required this.isFavorite,
    required this.showBadge,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (category.isNotEmpty)
              Text(
                category.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                  color: theme.colorScheme.primary,
                ),
              ),
            const Spacer(),
            // Поява бейджа при зміні стану Switch зі зміною кольору та стилю
            if (showBadge)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade700, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, size: 14, color: Colors.green.shade800),
                    const SizedBox(width: 4),
                    Text(
                      'В НАЯВНОСТІ',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                  // Зміна стилю/кольору тексту залежно від стану Switch
                  color: showBadge ? theme.colorScheme.primary : Colors.black,
                ),
              ),
            ),
            // Інтерактивна іконка "обране" (змінює колір з сірого на червоний)
            IconButton(
              onPressed: onFavoriteToggle,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey.shade400,
                size: 28,
              ),
              tooltip: isFavorite ? 'Видалити з обраного' : 'Додати в обране',
            ),
          ],
        ),
      ],
    );
  }
}
