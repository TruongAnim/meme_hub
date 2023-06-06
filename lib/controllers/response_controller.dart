import 'package:get/get.dart';
import 'package:meme_hub/services/user_service.dart';

// currently unused
class ResponseController extends GetxController {
  UserService userService = UserService.instance;

  List<String> upvotes;
  List<String> downvotes;
  List<String> comments;

  RxInt countUpvote = RxInt(0);
  RxInt countDownvote = RxInt(0);
  RxInt countComment = RxInt(0);
  RxBool isUpvote = RxBool(false);
  RxBool isDownvote = RxBool(false);

  ResponseController(
      {required this.upvotes,
      required this.downvotes,
      required this.comments}) {
    print('create new response');
  }

  @override
  void onReady() {
    super.onReady();
    countUpvote.value = upvotes.length;
    countDownvote.value = downvotes.length;
    countComment.value = comments.length;
    if (upvotes.contains(userService.currentUser.id)) {
      isUpvote.value = true;
    } else if (downvotes.contains(userService.currentUser.id)) {
      isDownvote.value = true;
    }
  }

  void onUpvote() {
    if (upvotes.contains(userService.currentUser.id)) {
      isUpvote.value = false;
      countUpvote.value -= 1;
    } else {
      isUpvote.value = true;
      countUpvote.value += 1;
    }
    if (downvotes.contains(userService.currentUser.id)) {
      isDownvote.value = false;
      countDownvote.value -= 1;
    }
    print('onUpvote ${countUpvote}');
  }

  void onDownvote() {
    if (downvotes.contains(userService.currentUser.id)) {
      isDownvote.value = false;
      countDownvote.value -= 1;
    } else {
      isDownvote.value = true;
      countDownvote.value += 1;
    }
    if (upvotes.contains(userService.currentUser.id)) {
      isUpvote.value = false;
      countUpvote.value -= 1;
    }
  }
}
