import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Post/response_item.dart';
import 'package:meme_hub/controllers/post_list_controller.dart';
import 'package:meme_hub/controllers/response_controller.dart';
import 'package:meme_hub/models/post.dart';
import 'package:meme_hub/models/user.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostItem extends StatelessWidget {
  final Post post;
  late User user;
  PostListController controller = Get.find();

  PostItem({super.key, required this.post}) {
    if (post.userId is User) {
      user = post.userId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final responseController = Get.put(ResponseController(
        upvotes: post.upVotes,
        downvotes: post.downVotes,
        comments: post.comments));
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.s,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/300'), // Provide the user avatar URL here
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
          Image.network(
            post.mediaLink,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
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
          GetBuilder<ResponseController>(
              builder: (responseController) => ResponseItem(
                    controller: responseController,
                  )),
        ],
      ),
    );
  }
}
