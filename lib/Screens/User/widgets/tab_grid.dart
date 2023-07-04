import 'package:flutter/material.dart';
import 'package:meme_hub/Screens/Post/widgets/post_item.dart';
import 'package:meme_hub/models/post.dart';

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
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => Divider(
              color: Colors.grey[200],
              thickness: 10,
            ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return PostItem(post: list[index]);
        });
  }
}
