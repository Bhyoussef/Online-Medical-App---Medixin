import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class PageDots extends StatelessWidget {
  const PageDots({
    super.key,
    required this.currentIndex,
    required this.length,
  });

  final int currentIndex;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) {
          final isActive = index == currentIndex;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 16 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.indicatorActive
                  : AppColors.indicatorInactive,
              borderRadius: BorderRadius.circular(99),
            ),
          );
        },
      ),
    );
  }
}
