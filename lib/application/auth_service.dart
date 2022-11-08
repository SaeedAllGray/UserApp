import 'package:dio/dio.dart';

class AuthService {
  static Future loginwithEmail(String email, String password) async {
    try {
      Response response = await Dio().post('https://reqres.in/api/login',
          data: {'email': email, 'password': password});
      print(response.data);
      return response.data['token'];
    } catch (e) {
      print(e);

      return '';
    }
  }
}
