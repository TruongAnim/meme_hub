import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:meme_hub/Screens/Post/widgets/post_item.dart';
import 'package:meme_hub/models/post.dart';
// import 'package:toktok/Theme/colors.dart';
// import 'package:toktok/models/video.dart';

class TabGrid extends StatelessWidget {
  final List<Post> list;
  final IconData? icon;
  final Function? onTap;
  final IconData? viewIcon;
  final bool showView;

  const TabGrid(this.list,
      {super.key,
      this.icon,
      this.onTap,
      this.viewIcon,
      required this.showView});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return PostItem(post: list[index]);
        });
  }
}
