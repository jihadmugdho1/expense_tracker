import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class AuthPawLogo extends StatelessWidget {
  const AuthPawLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(Icons.pets, color: AppColors.lightTextDisabled, size: 18),
        const SizedBox(width: 4),
        Icon(Icons.pets, color: AppColors.lightTextDisabled, size: 26),
      ],
    );
  }
}
