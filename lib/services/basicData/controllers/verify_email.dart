import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:the_disease_fighter/services/base_url/ApiCookies.dart';

class VerifyEmailController {
  Dio _dio = Dio();

  late PersistCookieJar persistentCookies;

  Future verifyEmail({
    String? name,
    String? email,
    String? password,
  }) async {
    _dio.options
      ..baseUrl = BaseUrl.url
      ..connectTimeout = 20000
      ..receiveTimeout = 20000
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      }
      ..headers = {
        'Content-Type': 'application/json',
      };

    final List<Cookie> cookies = [Cookie('set-cookie', 'xxxxx')];

    (await ApiCookies.cookieJar)
        .saveFromResponse(Uri.parse(BaseUrl.url), cookies);

    _dio.interceptors.add(CookieManager(await ApiCookies.cookieJar));

    Map data = {
      "name": name,
      "email": email,
      "password": password,
    };
    try {
      var response = await _dio.post('/verify', data: data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        response.data.putIfAbsent('success', () => true);
        print(response.data);
        return response.data;
      } else {
        print(response.data);
        response.data.putIfAbsent('success', () => false);
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      Map error = {
        'success': false,
        'message': 'Fail to sign up , check your internet'
      };
      return error;
    }
  }
}