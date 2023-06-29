import 'package:dio/dio.dart';
import 'package:meme_hub/models/tag.dart';
import 'package:meme_hub/services/user_service.dart';
import 'package:meme_hub/utils/api_constants.dart';

class TagService {
  TagService._();
  static final TagService _instance = TagService._();
  static TagService get instance => _instance;
  static List<Tag>? cachedTags;
  final Dio _dio = Dio();

  Future<List<Tag>> getTags() async {
    const url = '${ApiConstants.baseUrl}/tags/get-tags';
    final response = await _dio.get(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${UserService.instance.currentUser.token}'
        },
      ),
    );
    if (response.statusCode == 200) {
      List<dynamic> tags = response.data;
      cachedTags = tags.map((e) => Tag.fromMap(e)).toList();
      return cachedTags!;
    } else {
      return List.empty();
    }
  }
}
