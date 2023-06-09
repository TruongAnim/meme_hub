import 'package:get/get.dart';
import 'package:meme_hub/Screens/ChangePassword/bindings/change_password_binding.dart';
import 'package:meme_hub/Screens/ChangePassword/change_password_screen.dart';
import 'package:meme_hub/Screens/Comment/comment_screen.dart';
import 'package:meme_hub/Screens/Home/home_screen.dart';
import 'package:meme_hub/Screens/ImageView/bindings/image_view_binding.dart';
import 'package:meme_hub/Screens/ImageView/image_view_screen.dart';
import 'package:meme_hub/Screens/Login/login_screen.dart';
import 'package:meme_hub/Screens/Reply/reply_screen.dart';
import 'package:meme_hub/Screens/Signup/signup_screen.dart';
import 'package:meme_hub/Screens/NewPost/new_post_screen.dart';
import 'package:meme_hub/Screens/UpdateInfo/bindings/update_info_binding.dart';
import 'package:meme_hub/Screens/UpdateInfo/update_info_screen.dart';
import 'package:meme_hub/Screens/User/bindings/user_binding.dart';
import 'package:meme_hub/Screens/Comment/bindings/comment_binding.dart';
import 'package:meme_hub/Screens/User/user_screen.dart';
import 'package:meme_hub/Screens/Welcome/welcome_screen.dart';
import 'package:meme_hub/Screens/Home/bindings/home_binding.dart';
import 'package:meme_hub/Screens/Login/bindings/login_binding.dart';
import 'package:meme_hub/Screens/Reply/bindings/reply_binding.dart';
import 'package:meme_hub/Screens/Signup/bindings/signup_binding.dart';
import 'package:meme_hub/Screens/NewPost/bindings/new_post_binding.dart';
import 'package:meme_hub/Screens/Welcome/bindings/welcome_binding.dart';

class AppRoutes {
  static const String home = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String user = '/user';
  static const String changePassword = '/changePassword';
  static const String upload = '/upload';
  static const String comment = '/comment';
  static const String reply = '/reply';
  static const String imageView = '/imageView';
  static const String updateInfo = '/updateInfo';

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
    GetPage(
        name: AppRoutes.changePassword,
        page: () => ChangePasswordScreen(),
        binding: ChangePasswordBinding()),
    GetPage(
        name: AppRoutes.upload,
        page: () => NewPostScreen(),
        binding: NewPostBinding()),
    GetPage(
        name: AppRoutes.comment,
        page: () => CommentScreen(),
        binding: CommentBinding()),
    GetPage(
        name: AppRoutes.reply,
        page: () => ReplyScreen(),
        binding: ReplyBinding()),
    GetPage(
        name: AppRoutes.imageView,
        page: () => ImageViewScreen(),
        binding: ImageViewBinding()),
    GetPage(
        name: AppRoutes.updateInfo,
        page: () => UpdateInfoScreen(),
        binding: UpdateInfoBinding()),
  ];
}
