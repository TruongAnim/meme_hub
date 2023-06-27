import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/User/controllers/user_controller.dart';
import 'package:meme_hub/Screens/User/widgets/header_widget.dart';
import 'package:meme_hub/Screens/User/widgets/sliver_app_delegate.dart';
import 'package:meme_hub/Screens/User/widgets/tab_grid.dart';
import 'package:meme_hub/Theme/colors.dart';
import 'package:meme_hub/core/helpers/assets_helper.dart';
import 'package:meme_hub/utils/common_utils.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = Get.arguments;
    return UserScreenBody(uid: data['userId']);
  }
}

class UserScreenBody extends StatefulWidget {
  final String uid;

  const UserScreenBody({super.key, required this.uid});
  @override
  _UserScreenBodyState createState() => _UserScreenBodyState();
}

class _UserScreenBodyState extends State<UserScreenBody> {
  final UserController _controller =
      Get.put(UserController(userId: Get.arguments['userId']));

  var followText;
  final key = UniqueKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 400.0,
                  floating: false,
                  actions: <Widget>[
                    PopupMenuButton(
                      color: backgroundColor,
                      icon: Icon(
                        Icons.more_vert,
                        color: secondaryColor,
                      ),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none),
                      itemBuilder: (BuildContext context) {
                        return [
                          // PopupMenuItem(
                          //   value: locale!.report,
                          //   textStyle: TextStyle(color: secondaryColor),
                          //   child: Text(locale.report!),
                          // ),
                          // PopupMenuItem(
                          //   value: locale.block,
                          //   textStyle: TextStyle(color: secondaryColor),
                          //   child: Text(locale.block!),
                          // ),
                        ];
                      },
                    )
                  ],
                  flexibleSpace: HeaderWidget(),
                ),
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                    TabBar(
                      labelColor: mainColor,
                      unselectedLabelColor: lightTextColor,
                      indicatorColor: transparentColor,
                      tabs: const [
                        Tab(icon: Icon(Icons.dashboard)),
                        Tab(icon: Icon(Icons.arrow_upward)),
                        Tab(
                          icon: ImageIcon(AssetImage(
                            AssetsHelper.icon_like,
                          )),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                GetBuilder<UserController>(
                    builder: (UserController controller) {
                  print('hello');
                  if (controller.upvotePost.isEmpty) {
                    return Container();
                  }
                  return TabGrid(
                    controller.upvotePost,
                    showView: false,
                  );
                }),
                GetBuilder<UserController>(
                    builder: (UserController controller) {
                  print('hello');
                  if (controller.upvotePost.isEmpty) {
                    return Container();
                  }
                  return TabGrid(
                    controller.upvotePost,
                    showView: false,
                  );
                }),
                FadedSlideAnimation(
                    beginOffset: Offset(0, 0.3),
                    endOffset: Offset(0, 0),
                    slideCurve: Curves.linearToEaseOut,
                    child: GetBuilder<UserController>(
                        builder: (UserController controller) {
                      if (controller.favouritePost.isEmpty) {
                        return Container();
                      }
                      return TabGrid(
                        controller.favouritePost,
                        showView: false,
                      );
                    })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
