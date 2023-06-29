import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Comment/controllers/comment_controller.dart';
import 'package:meme_hub/models/comment.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/services/user_service.dart';
import 'package:fluttericon/typicons_icons.dart';

class CommentResponseItem extends StatefulWidget {
  Comment comment;
  bool showReply;
  CommentResponseItem({
    Key? key,
    required this.comment,
    required this.showReply,
  }) : super(key: key);

  @override
  State<CommentResponseItem> createState() => _CommentResponseItemState();
}

class _CommentResponseItemState extends State<CommentResponseItem> {
  User currentUser = UserService.instance.currentUser;
  CommentController controller = Get.find();

  _upvote() {
    setState(() {
      if (widget.comment.upVotes.contains(currentUser.id)) {
        widget.comment.upVotes.remove(currentUser.id);
        controller.upvote(widget.comment.id, false);
      } else {
        widget.comment.upVotes.add(currentUser.id);
        controller.upvote(widget.comment.id, true);
      }
    });
  }

  _favourite() {
    setState(() {
      if (widget.comment.favourites.contains(currentUser.id)) {
        widget.comment.favourites.remove(currentUser.id);
        controller.favourite(widget.comment.id, false);
      } else {
        widget.comment.favourites.add(currentUser.id);
        controller.favourite(widget.comment.id, true);
      }
    });
  }

  _comment() {
    controller.comment(widget.comment);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            _upvote();
          },
          icon: Icon(
            Typicons.up,
            color: widget.comment.upVotes.contains(currentUser.id)
                ? Colors.green
                : Colors.grey,
          ),
          padding: const EdgeInsets.only(right: 6),
          constraints: const BoxConstraints(),
        ),
        Text(
          widget.comment.upVotes.length.toString(),
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () {
            _favourite();
          },
          icon: Icon(
            Icons.favorite,
            color: widget.comment.favourites.contains(currentUser.id)
                ? Colors.red
                : Colors.grey,
          ),
        ),
        Text(
          widget.comment.favourites.length.toString(),
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
        ),
        if (widget.showReply)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    _comment();
                  },
                  child: Text(
                    'Reply ${widget.comment.comments.length.toString()}',
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(width: 10)
              ],
            ),
          ),
      ],
    );
  }
}
