import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../theme/es_colors.dart';

enum EsButtonVariant { primary, secondary, ghost, danger }
enum EsButtonSize { small, medium, large }

class EsButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final EsButtonVariant variant;
  final EsButtonSize size;
  final bool isLoading;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? width;

  const EsButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = EsButtonVariant.primary,
    this.size = EsButtonSize.large,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
  });

  @override
  State<EsButton> createState() => _EsButtonState();
}

class _EsButtonState extends State<EsButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.onPressed == null || widget.isLoading;
    
    double height;
    switch (widget.size) {
      case EsButtonSize.small: height = 36; break;
      case EsButtonSize.medium: height = 44; break;
      case EsButtonSize.large: height = 52; break;
    }

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: isDisabled ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: 100.ms,
        width: widget.width,
        height: height,
        decoration: _getDecoration(isDisabled),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Center(
            child: widget.isLoading 
              ? const SpinKitThreeBounce(color: Colors.white, size: 20)
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.prefixIcon != null) ...[
                      Icon(widget.prefixIcon, color: _getTextColor(isDisabled), size: 18),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.text,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: _getTextColor(isDisabled),
                        fontSize: widget.size == EsButtonSize.small ? 13 : 15,
                      ),
                    ),
                    if (widget.suffixIcon != null) ...[
                      const SizedBox(width: 8),
                      Icon(widget.suffixIcon, color: _getTextColor(isDisabled), size: 18),
                    ],
                  ],
                ),
          ),
        ),
      )
      .animate(target: _isPressed ? 1 : 0)
      .scale(begin: const Offset(1, 1), end: const Offset(0.96, 0.96), duration: 100.ms),
    );
  }

  BoxDecoration _getDecoration(bool isDisabled) {
    final double opacity = isDisabled ? 0.4 : 1.0;

    switch (widget.variant) {
      case EsButtonVariant.primary:
        return BoxDecoration(
          gradient: EsColors.gradientPrimary,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: EsColors.primary.withValues(alpha: 0.3 * opacity),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        );
      case EsButtonVariant.secondary:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: EsColors.primary.withValues(alpha: opacity), width: 1.5),
        );
      case EsButtonVariant.ghost:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        );
      case EsButtonVariant.danger:
        return BoxDecoration(
          gradient: EsColors.gradientAccent,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: EsColors.accent.withValues(alpha: 0.3 * opacity),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        );
    }
  }

  Color _getTextColor(bool isDisabled) {
    final double opacity = isDisabled ? 0.4 : 1.0;
    if (widget.variant == EsButtonVariant.primary || widget.variant == EsButtonVariant.danger) {
      return Colors.white.withValues(alpha: opacity);
    }
    return EsColors.primary.withValues(alpha: opacity);
  }
}
