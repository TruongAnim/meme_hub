import 'package:flutter/material.dart';
import 'package:meme_hub/components/comment_response_item.dart';
import 'package:meme_hub/models/comment.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/utils/temp_data.dart';
import 'package:timeago/timeago.dart' as timeago;

enum CommentItemType { inPost, fullSize, inReply }

class CommentItem extends StatelessWidget {
  CommentItem({super.key, required this.comment, required this.type});
  Comment comment;
  CommentItemType type;

  @override
  Widget build(BuildContext context) {
    User user = TempData.getTempUser();
    if (comment.userId is User) {
      user = comment.userId;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      timeago.format(comment.createdAt),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(comment.content),
                if (comment.mediaLink.isNotEmpty)
                  Image.network(comment.mediaLink),
                CommentResponseItem(
                    comment: comment,
                    showReply: type == CommentItemType.inPost),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
