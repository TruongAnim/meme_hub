import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Home/drawer_widget.dart';
import 'package:meme_hub/Screens/Home/home_appbar.dart';
import 'package:meme_hub/Screens/Post/post_list.dart';
import 'package:meme_hub/controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
            appBar: const SliderAppBar(
                appBarColor: Colors.white,
                title: Text('hello',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w700))),
            slider: DrawerWidget(),
            child: PostList()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            HomeController controller = Get.find();
            controller.toUploadScreen();
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}
