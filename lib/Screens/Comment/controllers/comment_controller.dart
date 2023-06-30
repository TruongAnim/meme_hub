import 'dart:io';

import 'package:get/get.dart';
import 'package:meme_hub/models/comment.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/cloud_service.dart';
import 'package:meme_hub/services/comment_service.dart';
import 'package:meme_hub/services/user_service.dart';

class CommentController extends GetxController {
  late String postId;
  final CommentService _commentService = CommentService.instance;
  User currentUser = UserService.instance.currentUser;
  RxList<Comment> comments = RxList();

  void setPostId(String postId) {
    this.postId = postId;
    updateData();
  }

  void updateData() async {
    comments.value = await CommentService.instance.getComment(postId);
  }

  Future<bool> sendComment(
      String commentText, List<File> commentImages, String postId) async {
    try {
      String commentType = 'text';
      String mediaLink = '';
      if (commentImages.isNotEmpty) {
        mediaLink = await CloudService.instance.uploadMedia(commentImages[0]);
        commentType = 'image';
      }
      bool result = await CommentService.instance
          .newComment(commentText, mediaLink, commentType, postId);
      if (result) {
        updateData();
        Get.focusScope?.unfocus();
      }
      return result;
    } catch (err) {
      return false;
    }
  }

  void upvote(String id, bool isUpvote) {
    _commentService.upvote(id, currentUser.id, isUpvote);
  }

  void favourite(String id, bool isDownvote) {
    _commentService.favourite(id, currentUser.id, isDownvote);
  }

  void comment(Comment comment) async {
    await Get.toNamed(AppRoutes.reply,
        arguments: {'comment': comment}, preventDuplicates: false);
    comments.refresh();
  }
}