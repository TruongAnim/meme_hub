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
          background: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                FadedScaleAnimation(
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                        UrlUtils.addPublicIfNeeded(_controller.user.avatar)),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    const SizedBox(width: 20),
                    Text(
                      _controller.user.name,
                      style: TextStyle(
                          fontSize: 20,
                          color: mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 12),
                    Image.asset(
                      AssetsHelper.icon_verified,
                      scale: 4,
                    ),
                    const Spacer(),
                  ],
                ),
                Text(
                  '@${CommonUtils.getUsernameFromEmail(controller.user.email)}',
                  style: TextStyle(fontSize: 14, color: lightTextColor),
                ),
                const Spacer(),
                FadedScaleAnimation(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ImageIcon(
                        const AssetImage(
                          AssetsHelper.icon_fb,
                        ),
                        color: linkColor,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ImageIcon(
                        const AssetImage(AssetsHelper.icon_twt),
                        color: linkColor,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ImageIcon(
                        const AssetImage(AssetsHelper.icon_insta),
                        color: linkColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  _controller.user.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: mainColor),
                ),
                // Spacer(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     ProfilePageButton(
                //         locale.message,
                //         () => Navigator.pushNamed(
                //             context, PageRoutes.chatPage)),
                //     SizedBox(width: 16),
                //     _profileController.user['isFollowing']
                //         ? ProfilePageButton(locale.following, () {
                //             _profileController.followUser();
                //           })
                //         : ProfilePageButton(
                //             locale.follow,
                //             () {
                //               _profileController.followUser();
                //             },
                //             color: mainColor,
                //             textColor: secondaryColor,
                //           ),
                //   ],
                // ),
                const Spacer(),
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
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
