import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/download_service.dart';
import 'package:meme_hub/utils/toast_maker.dart';

class MediaController extends GetxController {
  Future<void> download(String url) async {
    DownloadService service = DownloadService.instance;
    String result = await service.downloadImage(url);
    ToastMaker.showToast(content: result);
  }

  void viewMedia({required type, required name, required time, required url}) {
    if (type == 'image') {
      Get.toNamed(AppRoutes.imageView,
          arguments: {'name': name, 'time': time, 'url': url});
    }
  }
}
