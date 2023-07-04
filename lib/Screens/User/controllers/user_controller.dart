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
  final RxMap<String, int> _counting =
      RxMap({"posts": 0, "comments": 0, "upvotes": 0});
  User get user => _user.value;
  List<Post> get userPost => _userPost;
  List<Post> get upvotePost => _upvotePost;
  List<Post> get favouritePost => _favouritePost;
  Map<String, int> get counting => _counting;

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
      update(['HeaderWidget'], true);
    }

    TaskResult getUserPost =
        await PostService.instance.getUserPosts(stackUserId.last);
    if (getUserPost.isSuccess) {
      _userPost.value = getUserPost.data as List<Post>;
      update(['userPost'], true);
      print('getUserPost done');
    }

    TaskResult getUpvotePost =
        await PostService.instance.getUpvotePosts(stackUserId.last);
    if (getUpvotePost.isSuccess) {
      _upvotePost.value = getUpvotePost.data as List<Post>;
      update(['upvotePost'], true);
    }

    TaskResult getFavouritePost =
        await PostService.instance.getFavouritePosts(stackUserId.last);
    if (getFavouritePost.isSuccess) {
      _favouritePost.value = getFavouritePost.data as List<Post>;
      update(['favouritePost'], true);
    }

    TaskResult getCounting =
        await UserService.instance.getUserActivity(stackUserId.last);
    if (getCounting.isSuccess) {
      Map<String, dynamic> data = getCounting.data as Map<String, dynamic>;
      _counting.value = {
        'posts': data['countPost'],
        'comments': data['countComment'],
        'upvotes': data['postUpvote'] + data['commentUpvote'],
      };
      update(['HeaderWidget'], true);
    }
  }
}
