import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.setCommentId(comment.id);
  }

  void _scrollTo(int index) {
    if (index >= 0 && index <= _controller.comments.length) {
      _scrollController.animateTo(
        index * 500.0,
        duration: Duration(milliseconds: 1000),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (_controller.comments.isNotEmpty) _scrollTo(1);
              return ListView.builder(
                controller: _scrollController,
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
