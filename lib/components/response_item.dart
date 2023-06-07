import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/controllers/post_list_controller.dart';
import 'package:meme_hub/models/post.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/services/user_service.dart';

class ResponseItem extends StatefulWidget {
  Post post;
  ResponseItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<ResponseItem> createState() => _ResponseItemState();
}

class _ResponseItemState extends State<ResponseItem> {
  User currentUser = UserService.instance.currentUser;
  PostListController controller = Get.find();

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

  _downvote() {
    setState(() {
      if (widget.post.favourites.contains(currentUser.id)) {
        widget.post.favourites.remove(currentUser.id);
        controller.downvote(widget.post.id, false);
      } else {
        widget.post.favourites.add(currentUser.id);
        controller.downvote(widget.post.id, true);
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
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              _upvote();
            },
            icon: Icon(
              Icons.arrow_upward,
              color: widget.post.upVotes.contains(currentUser.id)
                  ? Colors.green
                  : Colors.grey,
            ),
          ),
          Text(widget.post.upVotes.length.toString()),
          IconButton(
            onPressed: () {
              _downvote();
            },
            icon: Icon(
              Icons.favorite,
              color: widget.post.favourites.contains(currentUser.id)
                  ? Colors.red
                  : Colors.grey,
            ),
          ),
          Text(widget.post.favourites.length.toString()),
          IconButton(
            onPressed: () {
              _comment();
            },
            icon: Icon(
              Icons.comment,
              color:
                  widget.post.comments.isNotEmpty ? Colors.black : Colors.grey,
            ),
          ),
          Text(widget.post.comments.length.toString()),
        ],
      ),
    );
  }
}
