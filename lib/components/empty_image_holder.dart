import 'package:flutter/material.dart';

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
      width: width,
      height: height,
      color: backgroundColor,
      child: Icon(
        Icons.image,
        size: 50,
        color: Colors.white,
      ),
    );
  }
}
