import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/components/post_item.dart';
import 'package:meme_hub/controllers/comment_controller.dart';
import 'package:meme_hub/models/post.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({super.key});
  CommentController _controller = Get.find();
  Post post = Get.arguments['post'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with the actual number of comments
              itemBuilder: (context, index) {
                if (index == 0) return PostItem(post: post);
                return ListTile(
                  title: Text('Comment $index'),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // TODO: Handle comment submission
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
