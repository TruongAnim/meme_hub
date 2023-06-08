import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/components/comment_box.dart';
import 'package:meme_hub/components/comment_item.dart';
import 'package:meme_hub/components/reply_box.dart';
import 'package:meme_hub/controllers/reply_controller.dart';
import 'package:meme_hub/models/comment.dart';

class ReplyScreen extends StatefulWidget {
  ReplyScreen({super.key});

  @override
  State<ReplyScreen> createState() => _ReplyScreenState();
}

class _ReplyScreenState extends State<ReplyScreen> {
  final ReplyController _controller = Get.find();
  Comment comment = Get.arguments['comment'];

  @override
  void initState() {
    super.initState();
    _controller.setCommentId(comment.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: _controller.comments.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return CommentItem(
                      comment: comment,
                      type: CommentItemType.fullSize,
                    );
                  }
                  return CommentItem(
                    comment: _controller.comments[index - 1],
                    type: CommentItemType.inReply,
                  );
                },
              );
            }),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: ReplyBox(
              commentId: comment.id,
            ),
          ),
        ],
      ),
    );
  }
}
