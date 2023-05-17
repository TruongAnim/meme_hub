import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/controllers/home_controller.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({super.key});

  @override
  _MainNavigationBarState createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<HomeController>();
      final selectedIndex = controller.selectedIndex.value;
      return BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          controller.changeTab(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tab 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Tab 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tab 3',
          ),
        ],
      );
    });
  }
}
