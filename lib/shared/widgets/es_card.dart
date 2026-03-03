import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/es_colors.dart';

enum EsCardVariant { normal, highlighted, featured }

class EsCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EsCardVariant variant;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  const EsCard({
    super.key,
    required this.child,
    this.onTap,
    this.variant = EsCardVariant.normal,
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: variant == EsCardVariant.highlighted 
            ? EsColors.primary.withValues(alpha: 0.5)
            : (variant == EsCardVariant.featured ? EsColors.primary : Colors.white.withValues(alpha: 0.08)),
          width: variant == EsCardVariant.normal ? 1 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: EsColors.primary.withValues(alpha: 0.15),
            blurRadius: 30,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              overlayColor: WidgetStateProperty.all(EsColors.primary.withValues(alpha: 0.1)),
              child: Padding(
                padding: padding ?? const EdgeInsets.all(16),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
