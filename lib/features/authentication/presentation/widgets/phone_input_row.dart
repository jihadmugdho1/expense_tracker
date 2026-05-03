import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petzy_optimized/core/common/global_widgets/text_field/reuseable_text_field.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';
import '../../controllers/auth_controller.dart';

class PhoneInputRow extends StatelessWidget {
  final TextEditingController phoneController;
  final AuthController authController;

  const PhoneInputRow({
    super.key,
    required this.phoneController,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => authController.showCountryPicker(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.background(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border(context)),
            ),
            child: Obx(
              () => Row(
                children: [
                  Text(
                    authController.selectedCountryFlag.value,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down, size: 18),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ProTextField(
            controller: phoneController,
            hintText: '(454) 726-0592',
            keyboardType: TextInputType.phone,
            validator: (v) =>
                (v == null || v.isEmpty) ? 'Phone number is required' : null,
          ),
        ),
      ],
    );
  }
}
