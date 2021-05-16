import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/models/ApiCookies.dart';
import 'package:the_disease_fighter/services/sessions/models/get_all_sessions-model.dart';

class GetAllSessionsController {
  Dio _dio = Dio();
  var cookieJar = CookieJar();
  GetSessionsController _session = GetSessionsController();

  Future _getSessions() async {
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

    var response = await _dio.get('/doctors/1/reviews');
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      print(response.toString());

      return response;
    } else {
      print(response.toString());
      return response;
      // throw Exception('Failed to get user data');
    }
  }

  Future<GetSessionsController?> loadSessionsList() async {
    var jsonString = await _getSessions();
    _session = GetSessionsController.fromJson(jsonString);
    return _session;
  }
}
