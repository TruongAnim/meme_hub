import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Home/drawer_widget.dart';
import 'package:meme_hub/Screens/Home/home_appbar.dart';
import 'package:meme_hub/Screens/Home/slider_widget.dart';
import 'package:meme_hub/Screens/Post/post_list.dart';
import 'package:meme_hub/controllers/home_controller.dart';
import 'package:meme_hub/utils/api_constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<HomeController>();

  String getTagName() {
    if (controller.tags.isEmpty) {
      return 'Meme Hub';
    } else {
      return controller.tags[controller.current.value].name;
    }
  }

  String getIcon() {
    if (controller.tags.isEmpty) {
      return '${ApiConstants.public}/images/house.png';
    } else {
      return '${ApiConstants.public}${controller.tags[controller.current.value].icon}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    void openDrawer() {
      _scaffoldKey.currentState?.openDrawer();
    }

    return Scaffold(
        key: _scaffoldKey,
        body: SliderDrawer(
            slideDirection: SlideDirection.RIGHT_TO_LEFT,
            appBar: SliderAppBar(
              title: Obx(
                () => Text(getTagName(),
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700)),
              ),
              trailing: GestureDetector(
                onTap: () {
                  openDrawer();
                },
                child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.network(getIcon()),
                  ),
                ),
              ),
            ),
            slider: SliderWidget(),
            child: PostList()),
        drawer: DrawerWidget(),
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
