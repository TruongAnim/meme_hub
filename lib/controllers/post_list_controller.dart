import 'package:get/get.dart';
import 'package:meme_hub/models/post.dart';

enum PostStatus { initial, success, failure }

class PostListController extends GetxController {
  RxList<Post> posts = RxList();
  Rx<PostStatus> status = Rx<PostStatus>(PostStatus.initial);
  RxBool hasReachedMax = RxBool(false);

  Future<void> _onPostFetched() async {
    if (hasReachedMax.value) return;
    try {
      if (status.value == PostStatus.initial) {
        final posts = await _fetchPosts();
        this.posts.value = posts;
        status.value = PostStatus.success;
        hasReachedMax.value = false;
        return;
      }
      final posts = await _fetchPosts(this.posts.value.length);
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
}
