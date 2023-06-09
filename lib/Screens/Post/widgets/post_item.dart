import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Post/widgets/list_tags.dart';
import 'package:meme_hub/Screens/Post/widgets/media_placeholder.dart';
import 'package:meme_hub/Screens/Post/widgets/post_response_item.dart';
import 'package:meme_hub/Screens/Post/widgets/user_card_widget.dart';
import 'package:meme_hub/Screens/Post/widgets/video_player_widget.dart';
import 'package:meme_hub/controllers/media_controller.dart';
import 'package:meme_hub/Screens/Post/controllers/post_controller.dart';
import 'package:meme_hub/models/post.dart';
import 'package:meme_hub/models/user.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostItem extends StatelessWidget {
  final Post post;
  late User user;
  PostController controller = Get.find();

  PostItem({super.key, required this.post}) {
    if (post.userId is User) {
      user = post.userId;
    }
  }

  void _viewMedia() {
    Get.find<MediaController>().viewMedia(
        type: post.type,
        name: user.name,
        time: post.createdAt,
        url: post.mediaLink);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
            onTap: () => controller.toUserInfo(user.id),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: UserCardWidget(
                  user: user, message: timeago.format(post.createdAt)),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: Text(
            post.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (post.type == 'image') ...[
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _viewMedia,
            child: Image.network(
              post.mediaLink,
              width: double.infinity,
              fit: BoxFit.contain,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child; // Return the actual image once it's loaded
                } else {
                  return MediaPlaceholder(
                      isLoading: true, aspectRatio: post.mediaAspectRatio);
                }
              },
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return MediaPlaceholder(
                    isLoading: false, aspectRatio: post.mediaAspectRatio);
              },
            ),
          ),
        ],
        if (post.type == 'video') ...[
          const SizedBox(height: 8),
          GestureDetector(
              onTap: _viewMedia,
              child: VideoPlayerWidget(
                source: post.mediaLink,
                placeholder: MediaPlaceholder(
                    isLoading: true, aspectRatio: post.mediaAspectRatio),
              )),
        ],
        Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: SizedBox(height: 40, child: ListTags(tagIds: post.tags))),
        PostResponseItem(post: post),
      ],
    );
  }
}
