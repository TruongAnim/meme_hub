import 'package:get/get.dart';
import 'package:meme_hub/models/post.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/services/post_service.dart';

enum PostStatus { initial, success, failure }

class PostListController extends GetxController {
  final PostService _postService = PostService();
  List<User> users = List.empty();
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

  void updateUsers() {
    for (Post item in posts) {
      // item.u
    }
  }
}
