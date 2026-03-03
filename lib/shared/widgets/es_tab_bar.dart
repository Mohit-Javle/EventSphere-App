import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/es_colors.dart';

class EsTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabChanged;

  const EsTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: EsColors.bgSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: EsColors.bgBorder, width: 1),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double tabWidth = (constraints.maxWidth - 8) / tabs.length;
          return Stack(
            children: [
              // Animated Indicator
              AnimatedPositioned(
                duration: 250.ms,
                curve: Curves.easeOutCubic,
                left: selectedIndex * tabWidth,
                child: Container(
                  width: tabWidth,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: EsColors.gradientPrimary,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: EsColors.primary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                ),
              ),
              // Tab Items
              Row(
                children: List.generate(tabs.length, (index) {
                  final bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () => onTabChanged(index),
                    child: Container(
                      width: tabWidth,
                      height: 36,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        tabs[index],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isSelected ? Colors.white : EsColors.textSecondary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
