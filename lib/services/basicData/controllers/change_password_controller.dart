import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/models/ApiCookies.dart';

class ChangePasswordController {
  Dio _dio = Dio();

  late PersistCookieJar persistentCookies;

  Future changePassword({
    String? currentPassword,
    String? newPassword,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _token = prefs.getString('access_token') ?? '';

    _dio.options
      ..baseUrl = BaseUrl.url
      ..connectTimeout = 20000
      ..receiveTimeout = 20000
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      }
      ..headers = {
        'authorization': 'Bearer ' + _token,
      };

    (await ApiCookies.cookieJar).loadForRequest(Uri.parse(BaseUrl.url));

    _dio.interceptors.add(CookieManager(await ApiCookies.cookieJar));

    Map data = {
      "current_password": currentPassword,
      "new_password": newPassword,
    };

    try {
      var response = await _dio.patch('/password', data: data);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data;
      } else {
        // throw Exception('Failed to Log In');
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      Map error = {
        'success': false,
        'message': 'Fail to change in , check your internet '
      };
      return error;
    }
  }
}
