import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Post/widgets/post_item.dart';
import 'package:meme_hub/Theme/colors.dart';
import 'package:meme_hub/components/comment_box.dart';
import 'package:meme_hub/components/comment_item.dart';
import 'package:meme_hub/Screens/Comment/controllers/comment_controller.dart';
import 'package:meme_hub/models/post.dart';

class CommentScreen extends StatefulWidget {
  CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final CommentController _controller = Get.find();
  Post post = Get.arguments['post'];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.setPostId(post.id);
  }

  void _scrollTo(int index) {
    if (index >= 0 && index <= _controller.comments.length) {
      _scrollController.animateTo(
        index * 500.0,
        duration: const Duration(milliseconds: 1000),
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
              // if (_controller.comments.isNotEmpty) _scrollTo(1);
              return ListView.separated(
                controller: _scrollController,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                itemCount: _controller.comments.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return PostItem(post: post);
                  return CommentItem(
                    comment: _controller.comments[index - 1],
                    type: CommentItemType.inPost,
                  );
                },
              );
            }),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(3, 0), // controls the shadow position
                ),
              ],
            ),
            child: CommentBox(
              postId: post.id,
            ),
          ),
        ],
      ),
    );
  }
}
