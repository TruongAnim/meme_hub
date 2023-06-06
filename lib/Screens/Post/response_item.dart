import 'package:flutter/material.dart';
import 'package:meme_hub/models/post.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/services/user_service.dart';

enum VoteState { upvote, downvote, none }

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
  VoteState voteState = VoteState.none;
  int countUpvote = 0;
  int countDownvote = 0;
  int countComment = 0;

  _updateData() {
    countUpvote = widget.post.upVotes.length;
    countDownvote = widget.post.downVotes.length;
    countComment = widget.post.comments.length;
    if (widget.post.upVotes.contains(currentUser.id)) {
      voteState = VoteState.upvote;
    }
    if (widget.post.downVotes.contains(currentUser.id)) {
      voteState = VoteState.downvote;
    }
  }

  _upvote() {
    setState(() {
      if (voteState == VoteState.downvote) {
        voteState = VoteState.upvote;
        countDownvote--;
        countUpvote++;
      } else if (voteState == VoteState.upvote) {
        voteState = VoteState.none;
        countUpvote--;
      } else {
        voteState = VoteState.upvote;
        countUpvote++;
      }
    });
  }

  _downvote() {
    setState(() {
      if (voteState == VoteState.downvote) {
        voteState = VoteState.none;
        countDownvote--;
      } else if (voteState == VoteState.upvote) {
        voteState = VoteState.downvote;
        countDownvote++;
        countUpvote--;
      } else {
        voteState = VoteState.downvote;
        countDownvote++;
      }
    });
  }

  _comment() {}

  @override
  void initState() {
    super.initState();
    _updateData();
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
              color: voteState == VoteState.upvote ? Colors.green : Colors.grey,
            ),
          ),
          Text(countUpvote.toString()),
          IconButton(
            onPressed: () {
              _downvote();
            },
            icon: Icon(
              Icons.arrow_downward,
              color: voteState == VoteState.downvote ? Colors.red : Colors.grey,
            ),
          ),
          Text(countDownvote.toString()),
          IconButton(
            onPressed: () {
              _comment();
            },
            icon: Icon(
              Icons.comment,
              color: countComment > 0 ? Colors.black : Colors.grey,
            ),
          ),
          Text(countComment.toString()),
        ],
      ),
    );
  }
}
