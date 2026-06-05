import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';

/// A square grid of small dots, used as a decorative element behind images.
class DotGrid extends StatelessWidget {
  final int rows;
  final int columns;
  final double dotSize;
  final double spacing;
  final Color color;

  const DotGrid({
    super.key,
    this.rows = 4,
    this.columns = 4,
    this.dotSize = 4,
    this.spacing = 6,
    this.color = AppColors.gray,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        rows,
        (_) => Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              columns,
              (_) => Padding(
                padding: EdgeInsets.only(right: spacing),
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A simple outlined square used as a decorative accent.
class OutlinedSquare extends StatelessWidget {
  final double size;
  final Color color;

  const OutlinedSquare({super.key, this.size = 84, this.color = AppColors.gray});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(border: Border.all(color: color)),
    );
  }
}
