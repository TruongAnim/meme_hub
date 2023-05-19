import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:meme_hub/utils/LogUtil.dart';
import 'package:meme_hub/utils/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  final Dio _dio = Dio();

  Future<bool> login(String email, String password) async {
    const url =
        '${ApiConstants.baseUrl}/login'; // Replace with your login endpoint

    try {
      final response = await _dio.post(
        url,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        // Login successful, extract and return the token
        final token = response.data['token'] as String;
        bool isTokenSaved = await saveTokenToSharedPreferences(token);
        return isTokenSaved;
      } else {
        return false;
      }
    } catch (error, stackTrace) {
      LogUtil.error('login', error, stackTrace);
      return false;
    }
  }

  Future<bool> saveTokenToSharedPreferences(String token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.setString('token', token);
    } catch (error, stackTrace) {
      LogUtil.error('login', error, stackTrace);
      return false;
    }
  }
}
