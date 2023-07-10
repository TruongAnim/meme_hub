import 'package:meme_hub/utils/api_constants.dart';

class UrlUtils {
  static String addPublicIfNeeded(String url) {
    if (!url.startsWith('http')) {
      return ApiConstants.publicUrl + url;
    } else {
      return url;
    }
  }
}
