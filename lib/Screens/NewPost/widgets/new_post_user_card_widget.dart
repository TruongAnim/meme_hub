import 'package:flutter/material.dart';
import 'package:meme_hub/constants.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/utils/common_utils.dart';
import 'package:meme_hub/utils/url_utils.dart';

class NewPostUserCardWidget extends StatelessWidget {
  NewPostUserCardWidget({super.key, required this.user});
  User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: defaultPadding / 2),
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
              '@${CommonUtils.getUsernameFromEmail(user.email)}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}
