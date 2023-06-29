import 'package:flutter/material.dart';

class NoTagSelectedWidget extends StatelessWidget {
  const NoTagSelectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Text(
          'No tag selected',
          style: TextStyle(
              color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Text(
          'Random meme is showing',
          style: TextStyle(
              color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w500),
        )
      ]),
    );
  }
}
