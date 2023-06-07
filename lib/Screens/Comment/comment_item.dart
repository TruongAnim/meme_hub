import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/controllers/comment_controller.dart';
import 'package:meme_hub/models/comment.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentItem extends StatelessWidget {
  CommentItem({super.key, required this.index});
  final CommentController _controller = Get.find();
  int index;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Comment comment = _controller.comments[index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        timeago.format(comment.createdAt),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(comment.content),
                  if (comment.mediaLink.isNotEmpty)
                    Image.network(comment.mediaLink),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
