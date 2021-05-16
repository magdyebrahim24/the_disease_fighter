import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/models/ApiCookies.dart';

class CreateSessionController {
  Dio _dio = Dio();
  late PersistCookieJar persistentCookies;

  Future createSession(
      {String? day,
      String? time,
      String? amPm,
      String? name,
      String? gender,
      String? phone,
      String? comment,
      String? periodId,
      String? previousPeriodId,
      String? docId}) async {
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
      "day": "Wednesday",
      "time": "07:30",
      "am_pm": "pm",
      "name": "Alice",
      "gender": "Male",
      "phone": "123412658102",
      "comment": "This is a test comment",
      "period_id": 120,
      "previous_period_id": 120
    };
    try {
      var response = await _dio.post('/doctors/$docId/sessions', data: data);
      print(response.toString());
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        response.data.putIfAbsent('success', () => true);
        print(response);
        return response.data;
      } else {
        print(response.data);
        // Map x = {'success' : false};
        response.data.putIfAbsent('success', () => false);
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      Map error = {'success': false, 'message': 'Fail to send try again '};
      return error;
    }
  }
}
