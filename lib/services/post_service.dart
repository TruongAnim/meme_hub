import 'package:dio/dio.dart';
import 'package:meme_hub/services/user_service.dart';
import 'package:meme_hub/utils/api_constants.dart';

class PostService {
  final Dio _dio = Dio();

  Future<bool> newPost(
      String title, String mediaLink, List<String> tags) async {
    const url = '${ApiConstants.baseUrl}/post/new-post';
    try {
      print(UserService.currentUser.token);
      final response = await _dio.post(
        url,
        data: {'title': title, 'mediaLink': mediaLink, 'tags': tags},
        options: Options(
          headers: {'Authorization': 'Bearer ${UserService.currentUser.token}'},
        ),
      );
      print(response);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
