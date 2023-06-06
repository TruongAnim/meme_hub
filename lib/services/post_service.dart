import 'package:dio/dio.dart';
import 'package:meme_hub/models/post.dart';
import 'package:meme_hub/services/user_service.dart';
import 'package:meme_hub/utils/LogUtil.dart';
import 'package:meme_hub/utils/api_constants.dart';

class PostService {
  final Dio _dio = Dio();

  Future<bool> newPost(
      String title, String mediaLink, List<String> tags) async {
    const url = '${ApiConstants.baseUrl}/post/new-post';
    try {
      final response = await _dio.post(
        url,
        data: {'title': title, 'mediaLink': mediaLink, 'tags': tags},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${UserService.instance.currentUser.token}'
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error, stackTrace) {
      LogUtil.error('newPost', error, stackTrace);
      return false;
    }
  }

  Future<List<Post>> fetchPosts(
      {String tag = 'all', int startIndex = 0}) async {
    String url = '${ApiConstants.baseUrl}/post/get-post/$tag';
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${UserService.instance.currentUser.token}'
          },
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        data.forEach((element) {
          print(element);
        });
        return data.map((e) => Post.fromMap(e)).toList();
      } else {
        return [];
      }
    } catch (error, stackTrace) {
      LogUtil.error('newPost', error, stackTrace);
      return [];
    }
  }

  Future<void> upvote(String postId, String userId, bool isUpvote) async {
    String url = '${ApiConstants.baseUrl}/post/upvote';
    try {
      Map<String, dynamic> data = {
        'postId': postId,
        'userId': userId,
        'isUpvote': isUpvote,
      };
      final response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${UserService.instance.currentUser.token}'
          },
        ),
      );
      if (response.statusCode == 200) {
        print('upvote successfully!');
      } else {}
    } catch (error, stackTrace) {
      LogUtil.error('newPost', error, stackTrace);
    }
  }

  Future<void> favourite(String postId, String userId, bool isFavourite) async {
    String url = '${ApiConstants.baseUrl}/post/favourite';
    try {
      Map<String, dynamic> data = {
        'postId': postId,
        'userId': userId,
        'isFavourite': isFavourite,
      };
      final response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${UserService.instance.currentUser.token}'
          },
        ),
      );
      if (response.statusCode == 200) {
        print('isFavourite successfully!');
      } else {}
    } catch (error, stackTrace) {
      LogUtil.error('newPost', error, stackTrace);
    }
  }
}
