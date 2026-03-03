import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/es_colors.dart';

enum EsChipVariant { filled, outlined, filter }

class EsChip extends StatelessWidget {
  final String label;
  final EsChipVariant variant;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  const EsChip({
    super.key,
    required this.label,
    this.variant = EsChipVariant.filled,
    this.isSelected = false,
    this.onTap,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFilter = variant == EsChipVariant.filter;
    final bool active = isFilter ? isSelected : variant == EsChipVariant.filled;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? EsColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: active ? Colors.transparent : EsColors.bgBorder,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: active ? Colors.white : EsColors.textSecondary,
                fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            if (onDismiss != null) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onDismiss,
                child: Icon(Icons.close, size: 14, color: active ? Colors.white : EsColors.textMuted),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
