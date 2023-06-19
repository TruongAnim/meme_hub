import 'package:get/get.dart';
import 'package:meme_hub/Screens/UpdateInfo/controllers/update_info_controller.dart';

class UpdateInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UpdateInfoController>(UpdateInfoController());
  }
}
