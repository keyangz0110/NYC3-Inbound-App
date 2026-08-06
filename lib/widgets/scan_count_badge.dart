import 'package:flutter/material.dart';

class ScanCountBadge extends StatelessWidget {
  const ScanCountBadge({
    super.key,
    required this.count,
    required this.semanticLabel,
    this.iconSize = 22,
    this.fontSize = 18,
    this.color,
  });

  final int count;
  final String semanticLabel;
  final double iconSize;
  final double fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final displayColor = color ?? Theme.of(context).colorScheme.onSurfaceVariant;

    return Semantics(
      label: semanticLabel,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.barcode_reader, size: iconSize, color: displayColor),
          const SizedBox(width: 6),
          Text(
            '$count',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: displayColor,
            ),
          ),
        ],
      ),
    );
  }
}
