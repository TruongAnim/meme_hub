import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Home/controllers/slider_controller.dart';
import 'package:meme_hub/Screens/Home/widgets/drawer_widget.dart';
import 'package:meme_hub/Screens/Home/widgets/slider_widget.dart';
import 'package:meme_hub/Screens/Post/post_list.dart';
import 'package:meme_hub/Screens/Home/controllers/home_controller.dart';
import 'package:meme_hub/utils/api_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<HomeController>();

  String getTagName() {
    if (controller.selectedTags.isEmpty) {
      return 'Meme Hub';
    } else {
      return controller.selectedTags[0].name;
    }
  }

  String getAvatar() {
    return controller.getUserAvatar();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<SliderDrawerState> _sliderKey =
        GlobalKey<SliderDrawerState>();

    void openDrawer() {
      _scaffoldKey.currentState?.openDrawer();
    }

    void openSlider() {
      _sliderKey.currentState?.toggle();
    }

    return Scaffold(
        key: _scaffoldKey,
        body: SliderDrawer(
            key: _sliderKey,
            slideDirection: SlideDirection.RIGHT_TO_LEFT,
            appBar: SliderAppBar(
              drawerIcon: GestureDetector(
                  onTap: openSlider,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(getAvatar()),
                    ),
                  )),
              title: Obx(
                () => Text(getTagName(),
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700)),
              ),
              trailing: GestureDetector(
                  onTap: () {
                    openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 4),
                    child: Icon(Icons.menu),
                  )),
            ),
            slider: SliderWidget(),
            child: PostList()),
        drawer: DrawerWidget(),
        onDrawerChanged: (isOpened) {
          if (!isOpened) {
            controller.closeDrawer();
          }
        },
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.toUploadScreen();
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}
