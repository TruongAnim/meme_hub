import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Post/widgets/media_placeholder.dart';
import 'package:meme_hub/Screens/Post/widgets/video_player_widget.dart';
import 'package:meme_hub/components/comment_response_item.dart';
import 'package:meme_hub/controllers/media_controller.dart';
import 'package:meme_hub/models/comment.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/utils/temp_data.dart';
import 'package:meme_hub/utils/url_utils.dart';
import 'package:timeago/timeago.dart' as timeago;

enum CommentItemType { inPost, fullSize, inReply }

class CommentItem extends StatelessWidget {
  CommentItem({super.key, required this.comment, required this.type});
  Comment comment;
  CommentItemType type;

  void _viewMedia() {
    Get.find<MediaController>().viewMedia(
        type: comment.type,
        name: 'user.name',
        time: comment.createdAt,
        url: comment.mediaLink);
  }

  @override
  Widget build(BuildContext context) {
    User user = TempData.getTempUser();
    if (comment.userId is User) {
      user = comment.userId;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 0, left: 8, right: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage:
                NetworkImage(UrlUtils.addPublicIfNeeded(user.avatar)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4,
                ),
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
                const SizedBox(height: 8.0),
                if (comment.content.isNotEmpty)
                  Text(
                    comment.content,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                if (comment.type == 'image') ...[
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _viewMedia,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        comment.mediaLink,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child; // Return the actual image once it's loaded
                          } else {
                            return MediaPlaceholder(
                                isLoading: true,
                                aspectRatio: comment.mediaAspectRatio);
                          }
                        },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return MediaPlaceholder(
                              isLoading: false,
                              aspectRatio: comment.mediaAspectRatio);
                        },
                      ),
                    ),
                  ),
                ],
                if (comment.type == 'video') ...[
                  const SizedBox(height: 8),
                  GestureDetector(
                      onTap: _viewMedia,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: VideoPlayerWidget(
                          source: comment.mediaLink,
                          placeholder: MediaPlaceholder(
                              isLoading: true,
                              aspectRatio: comment.mediaAspectRatio),
                        ),
                      )),
                ],
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
