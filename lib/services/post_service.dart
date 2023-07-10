import 'package:dio/dio.dart';
import 'package:meme_hub/models/post.dart';
import 'package:meme_hub/services/user_service.dart';
import 'package:meme_hub/utils/LogUtil.dart';
import 'package:meme_hub/utils/api_constants.dart';
import 'package:meme_hub/utils/task_result.dart';

class PostService {
  PostService._();
  static final PostService _instance = PostService._();
  static PostService get instance => _instance;
  final Dio _dio = Dio();

  Future<bool> newPost(String title, String mediaLink, String type,
      List<String> tags, double mediaAspectRatio) async {
    const url = '${ApiConstants.apiUrl}/post/new-post';
    try {
      final response = await _dio.post(
        url,
        data: {
          'title': title,
          'mediaLink': mediaLink,
          'type': type,
          'tags': tags,
          'mediaAspectRatio': mediaAspectRatio,
        },
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
      {required List<String> tags, int start = 0, int limit = 100}) async {
    String url = '${ApiConstants.apiUrl}/post/get-post/';
    try {
      final response = await _dio.post(
        url,
        data: {'tags': tags, 'start': start, 'limit': limit},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${UserService.instance.currentUser.token}'
          },
          validateStatus: (status) => true,
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((e) => Post.fromMap(e)).toList();
      } else {
        return [];
      }
    } catch (error, stackTrace) {
      LogUtil.error('fetchPosts', error, stackTrace);
      return [];
    }
  }

  Future<TaskResult> getUserPosts(String userId) async {
    String url = '${ApiConstants.apiUrl}/post/get-user-post';
    try {
      final response = await _dio.post(
        url,
        data: {'userId': userId},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${UserService.instance.currentUser.token}'
          },
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return TaskResult(
            isSuccess: true, data: data.map((e) => Post.fromMap(e)).toList());
      } else {
        return TaskResult(isSuccess: false);
      }
    } catch (error, stackTrace) {
      LogUtil.error('getUserPosts', error, stackTrace);
      return TaskResult(isSuccess: false);
    }
  }

  Future<TaskResult> getUpvotePosts(String userId) async {
    String url = '${ApiConstants.apiUrl}/post/get-upvote-post';
    try {
      final response = await _dio.post(
        url,
        data: {'userId': userId},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${UserService.instance.currentUser.token}'
          },
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return TaskResult(
            isSuccess: true, data: data.map((e) => Post.fromMap(e)).toList());
      } else {
        return TaskResult(isSuccess: false);
      }
    } catch (error, stackTrace) {
      LogUtil.error('getUpvotePosts', error, stackTrace);
      return TaskResult(isSuccess: false);
    }
  }

  Future<TaskResult> getFavouritePosts(String userId) async {
    String url = '${ApiConstants.apiUrl}/post/get-favourite-post';
    try {
      final response = await _dio.post(
        url,
        data: {'userId': userId},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${UserService.instance.currentUser.token}'
          },
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return TaskResult(
            isSuccess: true, data: data.map((e) => Post.fromMap(e)).toList());
      } else {
        return TaskResult(isSuccess: false);
      }
    } catch (error, stackTrace) {
      LogUtil.error('getFavouritePosts', error, stackTrace);
      return TaskResult(isSuccess: false);
    }
  }

  Future<void> upvote(String postId, String userId, bool isUpvote) async {
    String url = '${ApiConstants.apiUrl}/post/upvote';
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
      } else {}
    } catch (error, stackTrace) {
      LogUtil.error('upvote', error, stackTrace);
    }
  }

  Future<void> favourite(String postId, String userId, bool isFavourite) async {
    String url = '${ApiConstants.apiUrl}/post/favourite';
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
      } else {}
    } catch (error, stackTrace) {
      LogUtil.error('favourite', error, stackTrace);
    }
  }
}
