import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class NextRingButton extends StatelessWidget {
  const NextRingButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.accentCyan,
          width: 14,
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 84,
          height: 84,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              shape: const CircleBorder(),
            ),
            onPressed: onPressed,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
