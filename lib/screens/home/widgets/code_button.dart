import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';

/// A bordered, monospace call-to-action button matching the design's
/// code-editor aesthetic (e.g. `Contact me!!`, `View all ~~>`).
class CodeButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool filled;

  const CodeButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.filled = false,
  });

  @override
  State<CodeButton> createState() => _CodeButtonState();
}

class _CodeButtonState extends State<CodeButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final bool active = widget.filled || _hovering;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            color: active ? AppColors.scrim : AppColors.transparent,
          ),
          child: Text(widget.label, style: AppTextStyles.button),
        ),
      ),
    );
  }
}

/// A subtle inline text link with a trailing symbol, e.g. `Read more ->`.
class CodeTextLink extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CodeTextLink({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Text(label, style: AppTextStyles.button),
      ),
    );
  }
}
