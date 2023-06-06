import 'package:get/get.dart';
import 'package:meme_hub/models/post.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/post_service.dart';
import 'package:meme_hub/services/user_service.dart';

enum PostStatus { initial, success, failure }

class PostListController extends GetxController {
  final User currentUser = UserService.instance.currentUser;
  final PostService _postService = PostService();
  RxList<Post> posts = RxList();
  Rx<PostStatus> status = Rx<PostStatus>(PostStatus.initial);
  RxBool hasReachedMax = RxBool(false);

  @override
  void onReady() {
    // Perform operations after the controller is ready
    super.onReady();
    print('onReady');
    _onPostFetched();
  }

  Future<void> _onPostFetched() async {
    if (hasReachedMax.value) return;
    try {
      if (status.value == PostStatus.initial) {
        final posts = await _postService.fetchPosts();
        this.posts.value = posts;
        status.value = PostStatus.success;
        hasReachedMax.value = false;
        return;
      }
      final posts = await _postService.fetchPosts();
      if (posts.isEmpty) {
        hasReachedMax.value = true;
      } else {
        status.value = PostStatus.success;
        this.posts.value.addAll(posts);
        hasReachedMax.value = true;
      }
    } catch (_) {
      status.value = PostStatus.failure;
    }
  }

  void upvote(String id, bool isUpvote) {
    _postService.upvote(id, currentUser.id, isUpvote);
  }

  void downvote(String id, bool isDownvote) {
    _postService.favourite(id, currentUser.id, isDownvote);
  }

  void comment(Post post) {
    Get.toNamed(AppRoutes.comment, arguments: {'post': post});
  }
}
