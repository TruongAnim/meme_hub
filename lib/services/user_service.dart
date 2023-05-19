import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/utils/LogUtil.dart';
import 'package:meme_hub/utils/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static late User currentUser;
  final Dio _dio = Dio();

  Future<bool> getUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token != null) {
        const url =
            '${ApiConstants.baseUrl}/get-user'; // Replace with your user endpoint

        final response = await _dio.get(
          url,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> data = response.data;
          currentUser = User(
              id: data['_id'],
              name: data['name'],
              email: data['email'],
              token: token);
          return true;
        }
      }

      return false; // No token or request failed
    } catch (error, stackTrace) {
      LogUtil.error('login', error, stackTrace);
      return false;
    }
  }
}
