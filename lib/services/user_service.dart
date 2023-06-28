import 'package:dio/dio.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/utils/LogUtil.dart';
import 'package:meme_hub/utils/api_constants.dart';
import 'package:meme_hub/utils/task_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  UserService._();
  static final UserService _instance = UserService._();
  static UserService get instance => _instance;
  late User currentUser;
  final Dio _dio = Dio();

  Future<bool> getUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token != null) {
        const url =
            '${ApiConstants.baseUrl}/user/get-user'; // Replace with your user endpoint

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
              avatar: data['avatar'],
              description: data['description'],
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

  Future<TaskResult> getUserInfo(String id) async {
    try {
      const url =
          '${ApiConstants.baseUrl}/user/get-user-info'; // Replace with your user endpoint

      final response = await _dio.get(
        url,
        data: {'userId': id},
        options: Options(
          headers: {'Authorization': 'Bearer ${currentUser.token}'},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        return TaskResult(isSuccess: true, data: User.fromMap(data));
      }

      return TaskResult(isSuccess: false);
    } catch (error, stackTrace) {
      LogUtil.error('login', error, stackTrace);
      return TaskResult(isSuccess: false);
    }
  }

  Future<TaskResult> updateUserInfo(
      String? name, String? description, String? avatar) async {
    try {
      if (currentUser.token != null) {
        const url =
            '${ApiConstants.baseUrl}/user/update-user-info'; // Replace with your user endpoint

        final response = await _dio.post(
          url,
          data: {'name': name, 'description': description, 'avatar': avatar},
          options: Options(
            headers: {'Authorization': 'Bearer ${currentUser.token}'},
          ),
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> data = response.data;
          await getUser();
          return TaskResult(isSuccess: true, title: 'Update successfully');
        }
      }

      return TaskResult(
          isSuccess: false,
          title: 'Update Failed',
          message: 'Token null'); // No token or request failed
    } catch (error, stackTrace) {
      LogUtil.error('login', error, stackTrace);
      return TaskResult(
          isSuccess: false, title: 'Update Failed', message: error.toString());
      ;
    }
  }

  Future<TaskResult> changePassword(String oldPass, String newPass) async {
    try {
      if (currentUser.token != null) {
        const url =
            '${ApiConstants.baseUrl}/user/change-password'; // Replace with your user endpoint

        final response = await _dio.post(
          url,
          data: {'oldPassword': oldPass, 'newPassword': newPass},
          options: Options(
            headers: {'Authorization': 'Bearer ${currentUser.token}'},
          ),
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> data = response.data;
          if (data['status'] == 'success') {
            return TaskResult(isSuccess: true, message: data['message']);
          } else {
            return TaskResult(isSuccess: false, message: data['message']);
          }
        }
      }
      return TaskResult(
          isSuccess: false,
          title: 'Update Failed',
          message: 'Token null'); // No token or request failed
    } catch (error, stackTrace) {
      LogUtil.error('login', error, stackTrace);
      return TaskResult(
          isSuccess: false, title: 'Update Failed', message: error.toString());
      ;
    }
  }
}
