import 'package:get/get.dart';
import 'package:meme_hub/Screens/Home/home_screen.dart';
import 'package:meme_hub/Screens/Login/login_screen.dart';
import 'package:meme_hub/Screens/Signup/signup_screen.dart';
import 'package:meme_hub/Screens/User/user_screen.dart';
import 'package:meme_hub/Screens/Welcome/welcome_screen.dart';
import 'package:meme_hub/bindings/home_binding.dart';
import 'package:meme_hub/bindings/login_binding.dart';
import 'package:meme_hub/bindings/signup_binding.dart';
import 'package:meme_hub/bindings/user_binding.dart';
import 'package:meme_hub/bindings/welcome_binding.dart';

class AppRoutes {
  static const String home = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String user = '/user';

  static List<GetPage<dynamic>> pages = [
    GetPage(
        name: AppRoutes.welcome,
        page: () => WelcomeScreen(),
        binding: WelcomeBinding()),
    GetPage(
        name: AppRoutes.login,
        page: () => LoginScreen(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.signup,
        page: () => SignUpScreen(),
        binding: SignupBinding()),
    GetPage(
        name: AppRoutes.home, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(
        name: AppRoutes.user, page: () => UserScreen(), binding: UserBinding()),
  ];
}
