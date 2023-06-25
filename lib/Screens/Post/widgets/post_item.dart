import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Post/widgets/post_response_item.dart';
import 'package:meme_hub/components/video_player_widget.dart';
import 'package:meme_hub/controllers/media_controller.dart';
import 'package:meme_hub/Screens/Post/controllers/post_controller.dart';
import 'package:meme_hub/models/post.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/utils/url_utils.dart';
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
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(UrlUtils.addPublicIfNeeded(user.avatar)),
              ),
              const SizedBox(width: 8),
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (post.type == 'image')
            GestureDetector(
              onTap: _viewMedia,
              child: Image.network(
                post.mediaLink,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          if (post.type == 'video')
            GestureDetector(
                onTap: _viewMedia,
                child: VideoPlayerWidget(source: post.mediaLink)),
          const SizedBox(height: 8),
          Text(
            post.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            timeago.format(post.createdAt),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          PostResponseItem(post: post),
        ],
      ),
    );
  }
}
