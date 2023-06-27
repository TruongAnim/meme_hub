import 'dart:async';

import 'package:get/get.dart';
import 'package:meme_hub/Screens/User/controllers/user_controller.dart';
import 'package:meme_hub/models/post.dart';
import 'package:meme_hub/models/tag.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/post_service.dart';
import 'package:meme_hub/services/user_service.dart';
import 'package:meme_hub/utils/temp_data.dart';

enum PostStatus { initial, success, failure }

class PostController extends GetxController {
  final User currentUser = UserService.instance.currentUser;
  final PostService _postService = PostService.instance;
  Tag currentTag = TempData.getTempTag();
  RxList<Post> posts = RxList();
  Rx<PostStatus> status = Rx<PostStatus>(PostStatus.initial);
  RxBool hasReachedMax = RxBool(false);
  bool _isThrottled = false;
  final int limitFetchPosts = 2;

  @override
  void onReady() {
    super.onReady();
    onPostFetched();
  }

  void updateTag(Tag tag) {
    currentTag = tag;
    status.value = PostStatus.initial;
    hasReachedMax.value = false;
    onPostFetched();
  }

  Future<List<Post>> _fetchPosts() async {
    if (currentTag.id.isNotEmpty) {
      return _postService.fetchPosts(
          tag: currentTag.id,
          start: status.value == PostStatus.initial ? 0 : posts.length,
          limit: limitFetchPosts);
    } else {
      return _postService.fetchPosts(start: posts.length, limit: 2);
    }
  }

  void throttle(Function callback, Duration interval) {
    if (!_isThrottled) {
      _isThrottled = true;
      callback();

      Timer(interval, () {
        _isThrottled = false;
      });
    }
  }

  void triggerEvent() {
    throttle(onPostFetched, const Duration(seconds: 1));
  }

  Future<void> onPostFetched() async {
    print('onPostFetched');
    await Future.delayed(const Duration(seconds: 1));
    if (hasReachedMax.value) return;
    try {
      if (status.value == PostStatus.initial) {
        this.posts.value = await _fetchPosts();
        status.value = PostStatus.success;
        hasReachedMax.value =
            this.posts.length == limitFetchPosts ? false : true;
        return;
      }
      final posts = await _fetchPosts();
      if (posts.isEmpty) {
        hasReachedMax.value = true;
      } else {
        status.value = PostStatus.success;
        this.posts.addAll(posts);
        hasReachedMax.value = false;
      }
    } catch (_) {
      status.value = PostStatus.failure;
    }
  }

  void toUserInfo(String userId) async {
    await Get.toNamed(AppRoutes.user,
        arguments: {'userId': userId}, preventDuplicates: false);
  }

  void upvote(String id, bool isUpvote) {
    _postService.upvote(id, currentUser.id, isUpvote);
  }

  void favourite(String id, bool isDownvote) {
    _postService.favourite(id, currentUser.id, isDownvote);
  }

  void comment(Post post) async {
    await Get.toNamed(AppRoutes.comment, arguments: {'post': post});
    posts.refresh();
  }
}
