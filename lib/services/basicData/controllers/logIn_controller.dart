import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:the_disease_fighter/services/base_url/ApiCookies.dart';
class LoginController {
  Dio _dio = Dio();
  late PersistCookieJar persistentCookies;
  Future userLogin({
    String? email,
    String? password,
  }) async {
    _dio.options
      ..baseUrl = BaseUrl.url
      ..connectTimeout = 20000 //5s
      ..receiveTimeout = 20000
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      }
      ..headers = {
        'Content-Type': 'application/json',
      };

    final List<Cookie> cookies = [Cookie('set-cookie', 'empty')];

    (await ApiCookies.cookieJar)
        .saveFromResponse(Uri.parse(BaseUrl.url), cookies);

    _dio.interceptors.add(CookieManager(await ApiCookies.cookieJar));
    Map data = {
      'email': email,
      'password': password,
    };

    try {
      var response = await _dio.post('/login', data: data);

      if (response.statusCode! >= 200 && response.statusCode! < 301) {
        // String accessToken = response.data['access_token'];
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString('access_token', '$accessToken');
        response.data.putIfAbsent('success', () => true);

        print(response.data);
        return response.data;
      } else {
        // throw Exception('Failed to Log In');
        print(response.data);
        // response.data.putIfAbsent('success', () => false);

        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      Map error = {
        'success': false,
        'message': 'Fail to sign in , check your internet'
      };
      return error;
    }
  }
}