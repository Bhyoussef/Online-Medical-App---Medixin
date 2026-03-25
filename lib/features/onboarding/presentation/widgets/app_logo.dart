import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.isBlueBackground});

  final bool isBlueBackground;

  @override
  Widget build(BuildContext context) {
    final iconColor = isBlueBackground ? Colors.white : AppColors.primaryBlue;
    final textColor = isBlueBackground ? Colors.white : AppColors.textPrimary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.health_and_safety_rounded, color: iconColor, size: 26),
        const SizedBox(width: 6),
        Text(
          'Medixin',
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}
