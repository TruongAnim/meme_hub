import 'package:get/get.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/services/user_service.dart';
import 'package:meme_hub/utils/task_result.dart';
import 'package:meme_hub/utils/temp_data.dart';

class UserController extends GetxController {
  final Rx<User> _user = Rx(TempData.getTempUser());
  User get user => _user.value;
  String userId;
  UserController({required this.userId});

  @override
  void onInit() {
    super.onInit();
    print(userId);
    loadData();
  }

  void loadData() async {
    TaskResult result = await UserService.instance.getUserInfo(userId);
    if (result.isSuccess) {
      _user.value = result.data as User;
    }
  }
}
