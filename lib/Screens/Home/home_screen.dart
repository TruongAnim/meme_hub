import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:meme_hub/components/main_navigation_bar.dart';
import 'package:meme_hub/controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final controller = Get.find<HomeController>();
        final selectedIndex = controller.selectedIndex.value;

        switch (selectedIndex) {
          case 0:
            return Tab1();
          case 1:
            return Tab2();
          case 2:
            return Tab3();
          default:
            return Tab1(); // Default tab
        }
      }),
      bottomNavigationBar: MainNavigationBar(),
    );
  }
}

class Tab1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Tab 1'),
      ),
    );
  }
}

class Tab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Tab 2'),
      ),
    );
  }
}

class Tab3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Tab 3'),
      ),
    );
  }
}
