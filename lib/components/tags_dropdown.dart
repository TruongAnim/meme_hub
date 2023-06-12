import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/controllers/new_post_controller.dart';
import 'package:meme_hub/models/tag.dart';
import 'package:meme_hub/utils/toast_maker.dart';

class TagsDropdown extends StatefulWidget {
  TagsDropdown({super.key, required this.selectedTags});
  List<Tag> selectedTags;

  @override
  State<TagsDropdown> createState() => _TagsDropdownState();
}

class _TagsDropdownState extends State<TagsDropdown> {
  NewPostController controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  void _onSelectItem(bool isSelected, Tag item) {
    if (isSelected) {
      if (widget.selectedTags.length == 1) {
        ToastMaker.showToast(content: 'Select at least one tag');
      } else {
        widget.selectedTags.remove(item);
      }
    } else {
      widget.selectedTags.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Obx(
        () {
          if (widget.selectedTags.isEmpty && controller.tags.isNotEmpty) {
            Tag meme = controller.tags.firstWhere(
                (element) => element.name == 'Meme',
                orElse: () => controller.tags.first);
            widget.selectedTags.add(meme);
          }
          return DropdownButton2(
            isExpanded: true,
            hint: Align(
              alignment: AlignmentDirectional.center,
              child: Text(
                'Select Tags',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
            items: controller.tags.map((item) {
              return DropdownMenuItem<Tag>(
                value: item,
                //disable default onTap to avoid closing menu when selecting an item
                enabled: false,
                child: StatefulBuilder(
                  builder: (context, menuSetState) {
                    final isSelected = widget.selectedTags.contains(item);
                    return InkWell(
                      onTap: () {
                        _onSelectItem(isSelected, item);
                        //This rebuilds the StatefulWidget to update the button's text
                        setState(() {});
                        //This rebuilds the dropdownMenu Widget to update the check mark
                        menuSetState(() {});
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            isSelected
                                ? const Icon(Icons.check_box_outlined)
                                : const Icon(Icons.check_box_outline_blank),
                            const SizedBox(width: 16),
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
            //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
            value:
                widget.selectedTags.isEmpty ? null : widget.selectedTags.last,
            onChanged: (value) {},
            selectedItemBuilder: (context) {
              return controller.tags.map(
                (item) {
                  return Container(
                    alignment: AlignmentDirectional.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      widget.selectedTags.map((e) => e.name).join(', '),
                      style: const TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  );
                },
              ).toList();
            },
            buttonStyleData: const ButtonStyleData(
              height: 40,
              width: 140,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.zero,
            ),
          );
        },
      ),
    );
  }
}