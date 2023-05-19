import 'package:dio/dio.dart';
import 'package:meme_hub/utils/LogUtil.dart';
import 'package:meme_hub/utils/api_constants.dart';

class SignupService {
  final Dio _dio = Dio();

  Future<bool> signup(String username, String email, String password) async {
    const url = '${ApiConstants.baseUrl}/signup';

    try {
      final response = await _dio.post(
        url,
        data: {'name': username, 'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        // Signup successful
        return true;
      } else {
        // Signup failed
        return false;
      }
    } catch (error, stackTrace) {
      LogUtil.error('login', error, stackTrace);
      return false;
    }
  }
}
