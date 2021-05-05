import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/models/ApiCookies.dart';
import 'package:the_disease_fighter/services/logged_user/models/user_data_model.dart';

class CurrentUserInfoController {
  Dio _dio = Dio();
  var cookieJar = CookieJar();

  UserDataModel _userData = UserDataModel();

  Future _getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _token = prefs.getString('access_token') ?? '';

    _dio.options
      ..baseUrl = BaseUrl.url
      ..connectTimeout = 10000 //5s
      ..receiveTimeout = 10000
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      }
      ..headers = {
        'authorization': 'Bearer ' + _token,
      };

    (await ApiCookies.cookieJar).loadForRequest(Uri.parse(BaseUrl.url));

    _dio.interceptors.add(CookieManager(await ApiCookies.cookieJar));

    var response = await _dio.get('/user');
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      print(response.data.toString());
      return response;
    } else {
      return response;
    }
  }

  Future<UserDataModel?> loadUserData() async {
    var jsonString, jsonResponse;
    jsonString = await _getCurrentUser();
    jsonResponse = json.decode(jsonString.toString());
    _userData = UserDataModel.fromJson(jsonResponse);
    print(_userData.currentUser!.name.toString());
    return _userData;
  }
}
