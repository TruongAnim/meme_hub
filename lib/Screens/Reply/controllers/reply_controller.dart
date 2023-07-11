import 'dart:io';

import 'package:get/get.dart';
import 'package:meme_hub/models/comment.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/services/cloud_service.dart';
import 'package:meme_hub/services/comment_service.dart';
import 'package:meme_hub/services/user_service.dart';

class ReplyController extends GetxController {
  late String commentId;
  final CommentService _commentService = CommentService.instance;
  User currentUser = UserService.instance.currentUser;
  RxList<Comment> comments = RxList();

  void setCommentId(String commentId) {
    this.commentId = commentId;
    updateData();
  }

  void updateData() async {
    comments.value = await CommentService.instance.getReply(commentId);
  }

  Future<bool> sendComment(String commentText, String type, List<File> media,
      double mediaAspectRatio, String commonId) async {
    try {
      String mediaLink = '';
      if (media.isNotEmpty) {
        mediaLink = await CloudService.instance.uploadMedia(media[0]);
      }
      bool result = await CommentService.instance
          .newReply(commentText, mediaLink, type, mediaAspectRatio, commentId);
      if (result) {
        updateData();
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
}
