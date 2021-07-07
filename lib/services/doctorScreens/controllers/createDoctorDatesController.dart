import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/services/base_url/ApiCookies.dart';

class CreateDoctorDateController {
  Dio _dio = Dio();
  var cookieJar = CookieJar();

  Future createDate({startTime, endTime, day}) async {
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

    Map data = {
      "start_time": startTime.toString(),
      "end_time": endTime.toString(),
      "day": day.toString()
    };
    try {
      var response = await _dio.post('/doctors/dates', data: data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print(response.data.toString());
        return response.data;
      } else {
        print(response.toString());
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      Map error = {
        'success': false,
        'message': 'Fail to send , check your internet connection'
      };
      return error;
    }
  }
}
