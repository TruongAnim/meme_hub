import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Post/widgets/post_item.dart';
import 'package:meme_hub/Screens/Post/controllers/post_controller.dart';
import 'package:meme_hub/models/post.dart';
import 'package:meme_hub/Screens/Post/widgets/bottom_loader.dart';

class PostList extends StatefulWidget {
  PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  PostController controller = Get.put(PostController());

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Post> listPost = controller.posts;
      if (controller.status == PostStatus.initial) {
        return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [CircularProgressIndicator(), Text('Fetching post...')],
            ));
      }
      return ListView.builder(
        controller: _scrollController,
        itemCount: controller.hasReachedMax.value
            ? listPost.length
            : listPost.length + 1,
        itemBuilder: (context, index) {
          return index >= listPost.length
              ? const BottomLoader()
              : PostItem(post: listPost[index]);
        },
      );
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) controller.triggerEvent();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
