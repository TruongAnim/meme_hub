import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/User/controllers/user_controller.dart';
import 'package:meme_hub/Screens/User/widgets/row_item.dart';
import 'package:meme_hub/Theme/colors.dart';
import 'package:meme_hub/core/helpers/assets_helper.dart';
import 'package:meme_hub/utils/common_utils.dart';
import 'package:meme_hub/utils/url_utils.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({super.key});
  final UserController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
        id: 'HeaderWidget',
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
                    backgroundImage: NetworkImage(
                        UrlUtils.addPublicIfNeeded(_controller.user.avatar)),
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
                  style: TextStyle(fontSize: 10, color: disabledTextColor),
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
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
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
                  children: <Widget>[
                    RowItem(_controller.counting['posts'].toString(), 'Posts'),
                    RowItem(_controller.counting['comments'].toString(),
                        'Comments'),
                    RowItem(
                        _controller.counting['upvotes'].toString(), 'Upvotes'),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
