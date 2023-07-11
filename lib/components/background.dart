import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final String? background;
  const Background({super.key, required this.child, this.background});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            if (background != null)
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(background!),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
