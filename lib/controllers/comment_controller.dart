import 'dart:io';

import 'package:get/get.dart';
import 'package:meme_hub/models/comment.dart';
import 'package:meme_hub/services/cloud_service.dart';
import 'package:meme_hub/services/comment_service.dart';

class CommentController extends GetxController {
  late String postId;
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
      String mediaLink = commentImages.isNotEmpty
          ? await CloudService.instance.uploadImage(commentImages[0])
          : '';
      bool result = await CommentService.instance
          .newComment(commentText, mediaLink, 'image', postId);
      if (result) {
        updateData();
      }
      return result;
    } catch (err) {
      return false;
    }
  }
}
