import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../theme/es_colors.dart';
import 'es_button.dart';

class EsEmptyState extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EsEmptyState({
    super.key,
    required this.title,
    required this.description,
    this.icon = LucideIcons.calendarX2,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: EsColors.bgSurface,
                shape: BoxShape.circle,
                border: Border.all(color: EsColors.bgBorder),
              ),
              child: Icon(icon, size: 48, color: EsColors.textMuted),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: EsColors.textMuted),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 32),
              EsButton(
                text: actionLabel!,
                onPressed: onAction!,
                size: EsButtonSize.medium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
