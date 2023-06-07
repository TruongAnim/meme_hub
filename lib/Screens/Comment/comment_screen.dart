import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Comment/comment_box.dart';
import 'package:meme_hub/Screens/Comment/comment_item.dart';
import 'package:meme_hub/components/post_item.dart';
import 'package:meme_hub/controllers/comment_controller.dart';
import 'package:meme_hub/models/post.dart';

class CommentScreen extends StatefulWidget {
  CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final CommentController _controller = Get.find();
  Post post = Get.arguments['post'];

  @override
  void initState() {
    super.initState();
    _controller.setPostId(post.id);
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
                  if (index == 0) return PostItem(post: post);
                  return CommentItem(comment: _controller.comments[index - 1]);
                },
              );
            }),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: CommentBox(
              post: post,
            ),
          ),
        ],
      ),
    );
  }
}
