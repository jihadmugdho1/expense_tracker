import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petzy_optimized/core/common/global_widgets/common_button/common_button.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';
import 'package:petzy_optimized/routes/app_routes.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/auth_paw_logo.dart';
import '../widgets/phone_input_row.dart';
import '../widgets/social_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // ── Top: pink hero section ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.58,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(color: AppColors.primary),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      'Login To Explore',
                      style: AppTextStyle(context).boldTextStyle(
                        fontSize: AppTextStyle.xxl,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom: white card ──
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
                child: Form(
                  key: controller.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AuthPawLogo(),
                      const SizedBox(height: 8),
                      Text(
                        'Phone Number',
                        style: AppTextStyle(context)
                            .boldTextStyle(fontSize: AppTextStyle.xl),
                      ),
                      const SizedBox(height: 16),
                      PhoneInputRow(
                        phoneController: controller.phoneController,
                        authController: controller,
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => ProElevatedButton(
                          text: 'Login',
                          isLoading: controller.isLoginLoading.value,
                          onPressed: controller.login,
                          borderRadius: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'Or',
                              style: AppTextStyle(context).regularTextStyle(
                                color: AppColors.textSecondary(context),
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SocialLoginButton(
                            label: 'Kakao',
                            icon: _KakaoIcon(),
                            onTap: controller.loginWithKakao,
                          ),
                          const SizedBox(width: 10),
                          SocialLoginButton(
                            label: 'Naver',
                            icon: _NaverIcon(),
                            onTap: controller.loginWithNaver,
                          ),
                          const SizedBox(width: 10),
                          SocialLoginButton(
                            label: 'Google',
                            icon: _GoogleIcon(),
                            onTap: controller.loginWithGoogle,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: GestureDetector(
                          onTap: () => Get.toNamed(AppRoute.signupScreen),
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: AppTextStyle(context).regularTextStyle(
                                color: AppColors.textSecondary(context),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Sign Up.',
                                  style: AppTextStyle(context)
                                      .semiBoldTextStyle(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KakaoIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: const Color(0xFFFFE812),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Text(
          'K',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3A1D1D),
          ),
        ),
      ),
    );
  }
}

class _NaverIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: const Color(0xFF03C75A),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Text(
          'N',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: const Center(
        child: Text(
          'G',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4285F4),
          ),
        ),
      ),
    );
  }
}
