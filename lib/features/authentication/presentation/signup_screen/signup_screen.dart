import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petzy_optimized/core/common/global_widgets/common_button/common_button.dart';
import 'package:petzy_optimized/core/common/global_widgets/text_field/reuseable_text_field.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';
import '../../controllers/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: controller.signupFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Cover image ──
              _CoverSection(controller: controller),

              // ── Profile image ──
              _ProfileImageSection(controller: controller),

              // ── Form ──
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _fieldLabel(context, 'Full Name'),
                    const SizedBox(height: 8),
                    ProTextField(
                      controller: controller.fullNameController,
                      hintText: 'Alex Johnson',
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Full name is required' : null,
                    ),
                    const SizedBox(height: 16),
                    _fieldLabel(context, 'Bio'),
                    const SizedBox(height: 8),
                    ProTextField(
                      controller: controller.bioController,
                      hintText:
                          'Pet lover and proud owner of Max, a golden retriever...',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    _fieldLabel(context, 'Email Address'),
                    const SizedBox(height: 8),
                    ProTextField(
                      controller: controller.emailController,
                      hintText: 'alex.johnson@example.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Email is required';
                        if (!v.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _fieldLabel(context, 'Phone Number'),
                    const SizedBox(height: 8),
                    ProTextField(
                      controller: controller.signupPhoneController,
                      hintText: '+1 (555) 123-4567',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    _fieldLabel(context, 'Location'),
                    const SizedBox(height: 8),
                    ProTextField(
                      controller: controller.locationController,
                      hintText: 'San Francisco, CA',
                      suffixIcon: const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _fieldLabel(context, 'Postal Code'),
                    const SizedBox(height: 8),
                    ProTextField(
                      controller: controller.postalCodeController,
                      hintText: '00000000',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 32),
                    Obx(
                      () => ProElevatedButton(
                        text: 'Continue',
                        isLoading: controller.isSignupLoading.value,
                        onPressed: controller.continueSignup,
                        borderRadius: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(BuildContext context, String label) {
    return Text(
      label,
      style: AppTextStyle(context)
          .semiBoldTextStyle(fontSize: AppTextStyle.md),
    );
  }
}

// ── Cover photo section ─────────────────────────────────────────────────────

class _CoverSection extends StatelessWidget {
  final AuthController controller;

  const _CoverSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Cover image (replace color with Image.asset/Image.file when available)
        Obx(() {
          if (controller.coverImagePath.value != null) {
            return SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                controller.coverImagePath.value!,
                fit: BoxFit.cover,
              ),
            );
          }
          return Container(
            height: 200,
            width: double.infinity,
            color: const Color(0xFF8B6C42),
            child: const Icon(Icons.image, size: 60, color: Colors.white38),
          );
        }),

        // Change Cover button
        Positioned(
          top: 0,
          right: 16,
          child: SafeArea(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.image_outlined, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Change Cover',
                      style: AppTextStyle(context)
                          .mediumTextStyle(fontSize: AppTextStyle.sm),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Profile image section ────────────────────────────────────────────────────

class _ProfileImageSection extends StatelessWidget {
  final AuthController controller;

  const _ProfileImageSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -44),
      child: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                // Avatar
                Obx(() {
                  if (controller.profileImagePath.value != null) {
                    return CircleAvatar(
                      radius: 52,
                      backgroundImage:
                          AssetImage(controller.profileImagePath.value!),
                    );
                  }
                  return const CircleAvatar(
                    radius: 52,
                    backgroundColor: Color(0xFFE8A87C),
                    child: Icon(Icons.person, size: 52, color: Colors.white),
                  );
                }),

                // Camera badge
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Upload Profile Photo',
            style: AppTextStyle(context)
                .mediumTextStyle(fontSize: AppTextStyle.md),
          ),
        ],
      ),
    );
  }
}
