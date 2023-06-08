import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/controllers/comment_controller.dart';
import 'package:meme_hub/models/comment.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/services/user_service.dart';

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
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              _upvote();
            },
            icon: Icon(
              Icons.arrow_upward,
              color: widget.comment.upVotes.contains(currentUser.id)
                  ? Colors.green
                  : Colors.grey,
            ),
          ),
          Text(widget.comment.upVotes.length.toString()),
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
          Text(widget.comment.favourites.length.toString()),
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
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
