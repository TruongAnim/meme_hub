import 'package:meme_hub/models/tag.dart';
import 'package:meme_hub/models/user.dart';

class TempData {
  static User getTempUser() {
    return User(
        id: '',
        name: 'unknown',
        email: 'unknown',
        description: 'None',
        avatar: '/images/default_avt.png',
        token: 'unknown');
  }

  static Tag getTempTag() {
    return Tag(id: '', name: 'Home', icon: '/images/house.png', posts: []);
  }
}
