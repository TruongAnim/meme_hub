import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/user_service.dart';
import 'package:meme_hub/utils/task_result.dart';
import 'package:meme_hub/utils/toast_maker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordController extends GetxController {
  RxString currentPassword = RxString('');
  RxString newPassword = RxString('');
  RxString confirmPassword = RxString('');
  RxString errorMessage = RxString('');

  void setCurrentPassword(String password) {
    currentPassword.value = password;
  }

  void setNewPassword(String password) {
    newPassword.value = password;
  }

  void setConfirmPassword(String password) {
    confirmPassword.value = password;
    if (confirmPassword.isNotEmpty && confirmPassword != newPassword) {
      errorMessage.value = 'Mật khẩu mới không khớp';
    } else {
      errorMessage.value = '';
    }
  }

  void changePassword() async {
    TaskResult result = await UserService.instance
        .changePassword(currentPassword.value, newPassword.value);
    if (result.isSuccess) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      Get.offAllNamed(AppRoutes.welcome);
      ToastMaker.showToast(
          content: 'Đổi mật khẩu thành công\n Hãy đăng nhập lại');
    } else {
      ToastMaker.showToast(content: 'Lỗi\n ${result.message}');
    }
  }
}
