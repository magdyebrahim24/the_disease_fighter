import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/services/base_url/ApiCookies.dart';

class PatientRegisterController {
  Dio _dio = Dio();

  late PersistCookieJar persistentCookies;

  Future register({
    String? name,
    String? email,
    String? password,
    bool? isDoctor,
    String? phone,
    String? location,
    String? gender,
    String? dob,
    String? about,
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

    print('$about ////////////////////////////////////');

    Map data = {
      "name": name,
      "email": email,
      "password": password,
      "is_doctor": isDoctor,
      "phone": phone.toString(),
      "location": location.toString(),
      "gender": gender.toString(),
      "about": about.toString(),
      "dob": dob.toString(),
    };
    try {
      var response = await _dio.post('/register', data: data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        String accessToken = response.data['access_token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', '$accessToken');
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