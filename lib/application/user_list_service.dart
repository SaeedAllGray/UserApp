import 'package:dio/dio.dart';
import 'package:user_app/domain/user/user.dart';

class UserService {
  static Future<List<User>> getUserList(int pageNo) async {
    try {
      Response response =
          await Dio().get('https://reqres.in/api/users?page=$pageNo');

      List<User> userList = (response.data['data'] as List)
          .map((userjson) => User.fromJson(userjson))
          .toList();
      return userList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<void> addUser(String fullName) async {
    try {
      await Dio().post('/api/users', data: {'name': fullName});
    } catch (e) {
      print(e);
    }
  }
}
