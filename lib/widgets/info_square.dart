import 'package:flutter/material.dart';

class InfoSquare extends StatelessWidget {
  const InfoSquare({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.backgroundColor,
    required this.foregroundColor,
    this.expanded = true,
    this.maximize = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool expanded;
  final bool maximize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(maximize ? 16 : 12);
    final child = maximize
        ? LayoutBuilder(
            builder: (context, constraints) {
              const edgePadding = 10.0;
              final innerWidth = constraints.maxWidth - edgePadding * 2;
              final innerHeight = constraints.maxHeight - edgePadding * 2;
              final shortestSide = innerHeight < innerWidth ? innerHeight : innerWidth;

              final iconSize = (shortestSide * 0.14).clamp(16.0, 24.0);
              final labelSize = (shortestSide * 0.09).clamp(11.0, 15.0);
              final headerHeight = iconSize + labelSize + 10;
              final valueAreaHeight = (innerHeight - headerHeight).clamp(0.0, innerHeight);
              final valueAreaWidth = innerWidth;

              return Material(
                color: backgroundColor,
                borderRadius: borderRadius,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: borderRadius,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.all(edgePadding),
                    child: Column(
                      children: [
                        Icon(icon, color: foregroundColor, size: iconSize),
                        const SizedBox(height: 2),
                        Text(
                          label,
                          style: TextStyle(
                            color: foregroundColor,
                            fontSize: labelSize,
                            fontWeight: FontWeight.w600,
                            height: 1.1,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: valueAreaHeight,
                          width: valueAreaWidth,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: foregroundColor,
                                  fontSize: valueAreaHeight,
                                  fontWeight: FontWeight.bold,
                                  height: 1.0,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Material(
            color: backgroundColor,
            borderRadius: borderRadius,
            child: InkWell(
              onTap: onTap,
              borderRadius: borderRadius,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: foregroundColor, size: 22),
                    const SizedBox(height: 6),
                    Text(
                      label,
                      style: TextStyle(
                        color: foregroundColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: TextStyle(
                        color: foregroundColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );

    if (expanded) {
      return Expanded(child: child);
    }
    return child;
  }
}
