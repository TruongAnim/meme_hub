import 'package:flutter/material.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/utils/common_utils.dart';
import 'package:meme_hub/utils/url_utils.dart';

class UserCardWidget extends StatelessWidget {
  UserCardWidget({super.key, required this.user, required this.message});
  User user;
  String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage:
              NetworkImage(UrlUtils.addPublicIfNeeded(user.avatar)),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${CommonUtils.getUsernameFromEmail(user.email)} - $message',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}
