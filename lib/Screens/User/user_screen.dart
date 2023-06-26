import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/User/controllers/user_controller.dart';
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
                  flexibleSpace: GetBuilder<UserController>(
                      builder: (UserController controller) {
                    if (_controller.user.name == 'unknown') {
                      return Container();
                    }
                    return FlexibleSpaceBar(
                      centerTitle: true,
                      title: Column(
                        children: <Widget>[
                          Spacer(flex: 10),
                          FadedScaleAnimation(
                            child: CircleAvatar(
                              radius: 28.0,
                              backgroundImage:
                                  NetworkImage(_controller.user.avatar),
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Spacer(flex: 12),
                              Text(
                                _controller.user.name,
                                style: const TextStyle(fontSize: 16),
                              ),
                              Spacer(),
                              Image.asset(
                                AssetsHelper.icon_verified,
                                scale: 4,
                              ),
                              Spacer(flex: 8),
                            ],
                          ),
                          Text(
                            '@${CommonUtils.getUsernameFromEmail(controller.user.email)}',
                            style: TextStyle(
                                fontSize: 10, color: disabledTextColor),
                          ),
                          Spacer(),
                          FadedScaleAnimation(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ImageIcon(
                                  AssetImage(
                                    AssetsHelper.icon_fb,
                                  ),
                                  color: secondaryColor,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                ImageIcon(
                                  AssetImage(AssetsHelper.icon_twt),
                                  color: secondaryColor,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                ImageIcon(
                                  AssetImage(AssetsHelper.icon_insta),
                                  color: secondaryColor,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text(
                            _controller.user.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // children: <Widget>[
                            //   ProfilePageButton(
                            //       locale.message,
                            //       () => Navigator.pushNamed(
                            //           context, PageRoutes.chatPage)),
                            //   SizedBox(width: 16),
                            //   _profileController.user['isFollowing']
                            //       ? ProfilePageButton(locale.following, () {
                            //           _profileController.followUser();
                            //         })
                            //       : ProfilePageButton(
                            //           locale.follow,
                            //           () {
                            //             _profileController.followUser();
                            //           },
                            //           color: mainColor,
                            //           textColor: secondaryColor,
                            //         ),
                            // ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // children: <Widget>[
                            //   RowItem(
                            //       _profileController.user['likes'],
                            //       locale.liked,
                            //       Scaffold(
                            //         appBar: AppBar(
                            //           title: const Text('Liked'),
                            //         ),
                            //         body: TabGrid(
                            //           _profileController.user['videos'],
                            //           showView: false,
                            //         ),
                            //       )),
                            //   RowItem(_profileController.user['followers'],
                            //       locale.followers, FollowersPage()),
                            //   RowItem(_profileController.user['following'],
                            //       locale.following, FollowingPage()),
                            // ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                    TabBar(
                      labelColor: mainColor,
                      unselectedLabelColor: lightTextColor,
                      indicatorColor: transparentColor,
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
                FadedSlideAnimation(
                  beginOffset: Offset(0, 0.3),
                  endOffset: Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                  child: GetBuilder<UserController>(
                      builder: (UserController controller) {
                    if (controller.myPost.isEmpty) {
                      return Container();
                    }
                    return TabGrid(
                      controller.myPost,
                      showView: false,
                    );
                  }),
                ),
                FadedSlideAnimation(
                    beginOffset: Offset(0, 0.3),
                    endOffset: Offset(0, 0),
                    slideCurve: Curves.linearToEaseOut,
                    child: GetBuilder<UserController>(
                        builder: (UserController controller) {
                      if (controller.myUpvote.isEmpty) {
                        return Container();
                      }
                      return TabGrid(
                        controller.myUpvote,
                        showView: false,
                      );
                    })),
                FadedSlideAnimation(
                    beginOffset: Offset(0, 0.3),
                    endOffset: Offset(0, 0),
                    slideCurve: Curves.linearToEaseOut,
                    child: GetBuilder<UserController>(
                        builder: (UserController controller) {
                      if (controller.myFavourite.isEmpty) {
                        return Container();
                      }
                      return TabGrid(
                        controller.myFavourite,
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
