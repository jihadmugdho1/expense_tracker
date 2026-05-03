import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petzy_optimized/core/common/global_widgets/common_button/common_button.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/auth_paw_logo.dart';
import '../widgets/otp_digit_box.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // ── Paw pattern background ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.56,
            child: Stack(
              children: [
                Container(color: AppColors.primary),
                Positioned.fill(
                  child: SvgPicture.asset(
                    'assets/images/backgroud.svg',
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      AppColors.white.withValues(alpha: 0.08),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                // Dog placeholder — replace with actual Image.asset when available
                Center(
                  child: Container(
                    width: size.width * 0.55,
                    height: size.height * 0.30,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 24),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.pets,
                      size: 72,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom white card ──
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: size.height * 0.50),
              decoration: const BoxDecoration(
                color: Color(0xFFFEF6F6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AuthPawLogo(),
                    const SizedBox(height: 12),
                    Text(
                      'Enter verification code',
                      style: AppTextStyle(context)
                          .boldTextStyle(fontSize: AppTextStyle.xl),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter Code Sent to Your Phone Number',
                      textAlign: TextAlign.center,
                      style: AppTextStyle(context).regularTextStyle(
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── OTP boxes ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        4,
                        (i) => OtpDigitBox(
                          controller: controller.otpControllers[i],
                          focusNode: controller.otpFocusNodes[i],
                          onChanged: (v) =>
                              controller.onOtpDigitChanged(v, i, context),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    Obx(
                      () => ProElevatedButton(
                        text: 'Verify Code',
                        isLoading: controller.isOtpLoading.value,
                        onPressed: controller.verifyOtp,
                        borderRadius: 14,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Resend section ──
                    Text(
                      "Didn't receive the code?",
                      style: AppTextStyle(context).regularTextStyle(
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: controller.resendOtp,
                      child: Text(
                        'Resend code',
                        style: AppTextStyle(context).semiBoldTextStyle(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
