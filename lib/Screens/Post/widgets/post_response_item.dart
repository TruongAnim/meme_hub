import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Post/controllers/post_controller.dart';
import 'package:meme_hub/models/post.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/services/user_service.dart';

class PostResponseItem extends StatefulWidget {
  Post post;
  PostResponseItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostResponseItem> createState() => _PostResponseItemState();
}

class _PostResponseItemState extends State<PostResponseItem> {
  User currentUser = UserService.instance.currentUser;
  PostController controller = Get.find();

  _upvote() {
    setState(() {
      if (widget.post.upVotes.contains(currentUser.id)) {
        widget.post.upVotes.remove(currentUser.id);
        controller.upvote(widget.post.id, false);
      } else {
        widget.post.upVotes.add(currentUser.id);
        controller.upvote(widget.post.id, true);
      }
    });
  }

  _favourite() {
    setState(() {
      if (widget.post.favourites.contains(currentUser.id)) {
        widget.post.favourites.remove(currentUser.id);
        controller.favourite(widget.post.id, false);
      } else {
        widget.post.favourites.add(currentUser.id);
        controller.favourite(widget.post.id, true);
      }
    });
  }

  _comment() {
    controller.comment(widget.post);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16),
        IconButton(
          onPressed: () {
            _upvote();
          },
          icon: Icon(
            Typicons.up,
            color: widget.post.upVotes.contains(currentUser.id)
                ? Colors.green
                : Colors.grey,
          ),
        ),
        Text(
          widget.post.upVotes.length.toString(),
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {
            _favourite();
          },
          icon: Icon(
            Icons.favorite,
            color: widget.post.favourites.contains(currentUser.id)
                ? Colors.red
                : Colors.grey,
          ),
        ),
        Text(
          widget.post.favourites.length.toString(),
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {
            _comment();
          },
          icon: Icon(
            Icons.comment,
            color: widget.post.comments.isNotEmpty ? Colors.black : Colors.grey,
          ),
        ),
        Text(
          widget.post.comments.length.toString(),
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
