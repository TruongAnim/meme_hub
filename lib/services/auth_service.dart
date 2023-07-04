import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/services/user_service.dart';
import 'package:meme_hub/utils/LogUtil.dart';
import 'package:meme_hub/utils/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._();
  static AuthService get instance => _instance;

  AuthService._();
  final Dio _dio = Dio();

  Future<bool> login(String email, String password) async {
    const url =
        '${ApiConstants.baseUrl}/auth/login'; // Replace with your login endpoint

    try {
      final response = await _dio.post(
        url,
        data: {'email': email, 'password': password},
      );
      print(response);
      if (response.statusCode == 200) {
        final token = response.data['token'] as String;
        UserService.instance.currentUser = User.fromMap(response.data);
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

  Future<bool> signup(String username, String email, String password) async {
    const url = '${ApiConstants.baseUrl}/auth/signup';

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
