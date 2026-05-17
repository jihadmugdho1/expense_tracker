import 'package:get/get.dart';
import 'package:flutter_tamplate/features/authentication/presentation/screens/login_screen.dart';
import 'package:flutter_tamplate/features/bottom_nav/presentaion/UI/bottom_nav_screen.dart';
import 'package:flutter_tamplate/features/splash/presentaion/UI/splash_screen.dart';

class AppRoute {
  static const String loginScreen = "/loginScreen";
  static const String splashScreen = "/splashScreen";
  static const String bottomNavScreen = "/bottomNavScreen";


  static const String internetlost = "/internetlost";
  static const String communityScreen = "/communityScreen";

  static String getLoginScreen() => loginScreen;
  static String getSplashScreen() => splashScreen;
  static String getBottomNavScreen() => bottomNavScreen;
 
  static List<GetPage> routes = [
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: bottomNavScreen, page: () => const BottomNavScreen()),

    
  ];
}
