import 'package:dio/dio.dart';
import 'package:meme_hub/utils/constant.dart';

class SignupService {
  final Dio _dio = Dio();

  Future<bool> signup(String username, String email, String password) async {
    const url =
        '${ApiConstant.baseUrl}/signup'; // Replace with your signup endpoint

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
    } catch (e) {
      // Error occurred
      print('Error: $e');
      return false;
    }
  }
}
