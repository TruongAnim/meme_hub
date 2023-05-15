import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:meme_hub/utils/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  final Dio _dio = Dio();

  Future<String?> login(String email, String password) async {
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
        if (!isTokenSaved) {
          return null;
        }
        return token;
      } else {
        // Login failed, return null
        return null;
      }
    } catch (e) {
      // Error occurred, return null
      print('Error: $e');
      return null;
    }
  }

  Future<bool> saveTokenToSharedPreferences(String token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.setString('token', token);
    } catch (e) {
      print('Error saving token to SharedPreferences: $e');
      return false;
    }
  }
}
