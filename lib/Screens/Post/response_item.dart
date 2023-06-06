// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:meme_hub/controllers/response_controller.dart';

class ResponseItem extends StatelessWidget {
  ResponseController controller;
  ResponseItem({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              controller.onUpvote();
            },
            icon: Icon(Icons.arrow_upward),
          ),
          Text(controller.countUpvote.toString()),
          IconButton(
            onPressed: () {
              controller.onDownvote();
            },
            icon: Icon(Icons.arrow_downward),
          ),
          Text(controller.countDownvote.toString()),
          IconButton(
            onPressed: () {
              // Handle comment button press
            },
            icon: Icon(Icons.comment),
          ),
          Text(controller.countComment.toString()),
        ],
      ),
    );
  }
}
