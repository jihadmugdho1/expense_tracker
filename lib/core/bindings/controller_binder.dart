import 'package:get/get.dart';
import 'package:expensetracker/core/services/network/internet_service.dart';
import 'package:expensetracker/features/authentication/controllers/auth_controller.dart';
import 'package:expensetracker/features/splash/controllers/splash_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put<InternetService>(InternetService(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<SplashController>(SplashController(), permanent: true);
   
  }
}
