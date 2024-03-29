import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/services/base_url/ApiCookies.dart';
class LogOutController {
  Dio _dio = Dio();
  Future userLogOut() async {
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

    try {
      var response = await _dio.get('/logout');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        response.data.putIfAbsent('success', () => true);
        print(response.toString());
        return response.data;
      } else {
        print(response.toString());
        response.data.putIfAbsent('success', () => false);
        return response.data;
      }
    } on DioError catch (e) {
      print(e.message);
      Map error = {'success': false, 'message': 'Fail to log out try again '};
      return error;
    }
  }
}