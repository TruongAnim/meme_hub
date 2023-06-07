import 'package:meme_hub/models/user.dart';

class TempData {
  static User getTempUser() {
    return User(id: '', name: 'unknown', email: 'unknown', token: 'unknown');
  }
}
