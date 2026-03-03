import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/es_colors.dart';

class EsTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? errorText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final int? maxLines;

  const EsTextField({
    super.key,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.errorText,
    this.keyboardType,
    this.onChanged,
    this.maxLines = 1,
  });

  @override
  State<EsTextField> createState() => _EsTextFieldState();
}

class _EsTextFieldState extends State<EsTextField> {
  bool _isFocused = false;
  bool _obscureText = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: 200.ms,
          decoration: BoxDecoration(
            color: EsColors.bgElevated,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.errorText != null 
                ? EsColors.error 
                : (_isFocused ? EsColors.primary : EsColors.bgBorder),
              width: 1.5,
            ),
            boxShadow: _isFocused ? [
              BoxShadow(
                color: EsColors.primary.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ] : [],
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.isPassword && _obscureText,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            maxLines: widget.maxLines,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hint,
              prefixIcon: widget.prefixIcon != null 
                ? Icon(widget.prefixIcon, color: _isFocused ? EsColors.primary : EsColors.textMuted, size: 20)
                : null,
              suffixIcon: widget.isPassword 
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: EsColors.textMuted,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _obscureText = !_obscureText),
                  )
                : (widget.controller?.text.isNotEmpty == true ? IconButton(
                    icon: const Icon(Icons.clear, color: EsColors.textMuted, size: 20),
                    onPressed: () => widget.controller?.clear(),
                  ) : null),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              widget.errorText!,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: EsColors.error),
            ),
          ).animate().slideY(begin: -0.5, end: 0, duration: 200.ms).fadeIn(),
      ],
    );
  }
}
