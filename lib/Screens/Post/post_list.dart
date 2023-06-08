import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meme_hub/components/post_item.dart';
import 'package:meme_hub/controllers/post_controller.dart';
import 'package:meme_hub/models/post.dart';

class PostList extends StatelessWidget {
  PostList({super.key});
  PostController controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Post> listPost = controller.posts.value;
      return ListView.builder(
        itemCount: listPost.length,
        itemBuilder: (context, index) {
          return PostItem(post: listPost[index]);
        },
      );
    });
  }
}
