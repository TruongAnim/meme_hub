import 'package:get/get.dart';
import 'package:meme_hub/models/post.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/services/post_service.dart';
import 'package:meme_hub/services/user_service.dart';
import 'package:meme_hub/utils/task_result.dart';
import 'package:meme_hub/utils/temp_data.dart';

class UserController extends GetxController {
  List<String> stackUserId = [];
  final Rx<User> _user = Rx(TempData.getTempUser());
  final RxList<Post> _userPost = RxList();
  final RxList<Post> _upvotePost = RxList();
  final RxList<Post> _favouritePost = RxList();
  User get user => _user.value;
  List<Post> get userPost => _userPost;
  List<Post> get upvotePost => _upvotePost;
  List<Post> get favouritePost => _favouritePost;
  UserController();

  void addUserId(String userId) {
    stackUserId.add(userId);
    loadData();
  }

  void removeUserId() {
    stackUserId.removeLast();
    if (stackUserId.isNotEmpty) {
      loadData();
    }
  }

  void loadData() async {
    TaskResult userInfoResult =
        await UserService.instance.getUserInfo(stackUserId.last);

    if (userInfoResult.isSuccess) {
      _user.value = userInfoResult.data as User;
    }
    TaskResult getUserPost =
        await PostService.instance.getUserPosts(stackUserId.last);
    if (getUserPost.isSuccess) {
      _userPost.value = getUserPost.data as List<Post>;
      update(['HeaderWidget'], true);
    }
    TaskResult getUpvotePost =
        await PostService.instance.getUpvotePosts(stackUserId.last);
    if (getUpvotePost.isSuccess) {
      _upvotePost.value = getUpvotePost.data as List<Post>;
    }
    TaskResult getFavouritePost =
        await PostService.instance.getFavouritePosts(stackUserId.last);
    if (getFavouritePost.isSuccess) {
      _favouritePost.value = getFavouritePost.data as List<Post>;
    }
  }
}
