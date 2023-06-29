import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Post/controllers/post_controller.dart';
import 'package:meme_hub/models/tag.dart';

class ListTags extends StatelessWidget {
  List<String> tagIds;
  ListTags({super.key, required this.tagIds});

  @override
  Widget build(BuildContext context) {
    PostController controller = Get.find();
    List<Tag> tags = controller.getTagFromId(tagIds);

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: tags.length,
      itemBuilder: (BuildContext context, int index) {
        Tag tag = tags[index];
        return Row(
          children: [
            ChoiceChip(
              label: Text(
                tag.name,
                style: const TextStyle(color: Colors.grey),
              ),
              backgroundColor: Colors.transparent,
              shape: const StadiumBorder(side: BorderSide(color: Colors.grey)),
              selected: false,
              onSelected: (bool selected) {},
            ),
            const SizedBox(width: 8.0)
          ],
        );
      },
    );
  }
}
