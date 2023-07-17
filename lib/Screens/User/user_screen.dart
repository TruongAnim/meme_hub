import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/User/controllers/user_controller.dart';
import 'package:meme_hub/Screens/User/widgets/header_widget.dart';
import 'package:meme_hub/Screens/User/widgets/sliver_app_delegate.dart';
import 'package:meme_hub/Screens/User/widgets/tab_grid.dart';
import 'package:meme_hub/Theme/colors.dart';
import 'package:meme_hub/core/helpers/assets_helper.dart';

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
  late UserController _controller;
  final key = UniqueKey();

  @override
  void initState() {
    super.initState();
    _controller = Get.find();
    _controller.addUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: backgroundColor,
                  expandedHeight: 300,
                  floating: false,
                  leading: const BackButton(
                    color: lightColor,
                  ),
                  actions: <Widget>[
                    PopupMenuButton(
                      color: backgroundColor,
                      icon: const Icon(
                        Icons.more_vert,
                        color: lightColor,
                      ),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none),
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem(
                            value: 'report',
                            textStyle: TextStyle(color: mainColor),
                            child: Text('Report'),
                          ),
                          const PopupMenuItem(
                            value: 'block',
                            textStyle: TextStyle(color: mainColor),
                            child: Text('Block'),
                          ),
                        ];
                      },
                    ),
                  ],
                  flexibleSpace: HeaderWidget(),
                ),
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                    const TabBar(
                      labelColor: secondaryColor,
                      unselectedLabelColor: lightTextColor,
                      indicatorColor: linkColor,
                      dividerColor: mainColor,
                      automaticIndicatorColorAdjustment: true,
                      tabs: [
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
                    id: 'userPost',
                    builder: (UserController controller) {
                      if (controller.userPost.isEmpty) {
                        return Container();
                      }
                      return TabGrid(
                        controller.userPost,
                        showView: false,
                      );
                    }),
                GetBuilder<UserController>(
                    id: 'upvotePost',
                    builder: (UserController controller) {
                      if (controller.upvotePost.isEmpty) {
                        return Container();
                      }
                      return TabGrid(
                        controller.upvotePost,
                        showView: false,
                      );
                    }),
                FadedSlideAnimation(
                    beginOffset: const Offset(0, 0.3),
                    endOffset: const Offset(0, 0),
                    slideCurve: Curves.linearToEaseOut,
                    child: GetBuilder<UserController>(
                        id: 'favouritePost',
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
