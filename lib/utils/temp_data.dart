import 'package:meme_hub/models/tag.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/utils/api_constants.dart';

class TempData {
  static User getTempUser() {
    return User(
        id: '',
        name: 'unknown',
        email: 'unknown',
        description: 'None',
        avatar: '/images/user.png',
        token: 'unknown');
  }

  static Tag getTempTag() {
    return Tag(id: '', name: 'Home', icon: '/images/house.png', posts: []);
  }
}
