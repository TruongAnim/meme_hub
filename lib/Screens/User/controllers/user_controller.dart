import 'package:get/get.dart';
import 'package:meme_hub/services/user_service.dart';
import 'package:meme_hub/utils/task_result.dart';

class UserController extends GetxController {
  String userId;
  UserController({required this.userId});
  void loadData() async {
    TaskResult result = await UserService.instance.getUserInfo(userId);
    if (result.isSuccess) {
      // user = result.data as User;
    }
  }
}
