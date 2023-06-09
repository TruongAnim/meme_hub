import 'package:get/get.dart';
import 'package:meme_hub/services/download_service.dart';
import 'package:meme_hub/utils/toast_maker.dart';

class ImageViewController extends GetxController {
  Future<void> download(String url) async {
    DownloadService service = DownloadService.instance;
    String result = await service.downloadImage(url);
    ToastMaker.showToast(content: result);
  }
}
