import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/models/ApiCookies.dart';

class DeleteDoctorDateController {
  Dio _dio = Dio();
  var cookieJar = CookieJar();

  Future deleteDate({required dateId}) async {
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
      var response = await _dio.delete('/doctors/dates/$dateId');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print(response.data.toString());
        print('response success');
        return response.data;
      } else {
        print(response.statusCode.toString());
        print(response.toString());
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      Map error = {
        'success': false,
        'message': 'Fail to delete , check your internet connection'
      };
      return error;
    }
  }
}
