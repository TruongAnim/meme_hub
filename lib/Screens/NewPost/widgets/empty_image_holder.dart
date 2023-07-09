import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:meme_hub/Theme/colors.dart';

class EmptyImageHolder extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;

  const EmptyImageHolder({
    Key? key,
    this.width = 200,
    this.height = 200,
    this.backgroundColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: const [16, 16],
          radius: const Radius.circular(16),
          color: lightColor,
          strokeWidth: 3,
          child: Container(
            alignment: Alignment.center,
            height: 200,
            child: const Icon(
              Icons.add_photo_alternate,
              size: 50,
              color: Colors.grey,
            ),
          )),
    );
  }
}
