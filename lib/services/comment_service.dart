import 'package:dio/dio.dart';
import 'package:meme_hub/models/comment.dart';
import 'package:meme_hub/services/user_service.dart';
import 'package:meme_hub/utils/LogUtil.dart';
import 'package:meme_hub/utils/api_constants.dart';

class CommentService {
  CommentService._();
  static final CommentService _instance = CommentService._();
  static CommentService get instance => _instance;
  final Dio _dio = Dio();

  Future<bool> newComment(
      String content, String mediaLink, String type, String postId) async {
    const url = '${ApiConstants.baseUrl}/comment/new-comment';
    try {
      final response = await _dio.post(
        url,
        data: {
          'userId': UserService.instance.currentUser.id,
          'content': content,
          'mediaLink': mediaLink,
          'type': type,
          'postId': postId
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
      LogUtil.error('newComment', error, stackTrace);
      return false;
    }
  }

  Future<bool> newReply(
      String content, String mediaLink, String type, String commentId) async {
    const url = '${ApiConstants.baseUrl}/comment/new-reply';
    try {
      final response = await _dio.post(
        url,
        data: {
          'userId': UserService.instance.currentUser.id,
          'content': content,
          'mediaLink': mediaLink,
          'type': type,
          'commentId': commentId
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
      LogUtil.error('newReply', error, stackTrace);
      return false;
    }
  }

  Future<List<Comment>> getComment(String postId) async {
    const url = '${ApiConstants.baseUrl}/comment/get-comment';
    final response = await _dio.get(
      url,
      data: {'postId': postId},
      options: Options(
        headers: {
          'Authorization': 'Bearer ${UserService.instance.currentUser.token}'
        },
      ),
    );
    if (response.statusCode == 200) {
      List<dynamic> comments = response.data;
      return comments.map((e) => Comment.fromMap(e)).toList();
    } else {
      return List.empty();
    }
  }

  Future<List<Comment>> getReply(String commentId) async {
    const url = '${ApiConstants.baseUrl}/comment/get-reply';
    final response = await _dio.get(
      url,
      data: {'commentId': commentId},
      options: Options(
        headers: {
          'Authorization': 'Bearer ${UserService.instance.currentUser.token}'
        },
      ),
    );
    if (response.statusCode == 200) {
      List<dynamic> comments = response.data;
      return comments.map((e) => Comment.fromMap(e)).toList();
    } else {
      return List.empty();
    }
  }

  Future<void> upvote(String commentId, String userId, bool isUpvote) async {
    String url = '${ApiConstants.baseUrl}/comment/upvote';
    try {
      Map<String, dynamic> data = {
        'commentId': commentId,
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
      LogUtil.error('upvote comment', error, stackTrace);
    }
  }

  Future<void> favourite(
      String commentId, String userId, bool isFavourite) async {
    String url = '${ApiConstants.baseUrl}/comment/favourite';
    try {
      Map<String, dynamic> data = {
        'commentId': commentId,
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
      LogUtil.error('favourite comment', error, stackTrace);
    }
  }
}
