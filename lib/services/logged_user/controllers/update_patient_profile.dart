import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/services/base_url/ApiCookies.dart';
class UpdatePatientProfileController {
  Dio _dio = Dio();
  late PersistCookieJar persistentCookies;
  Future updatePatientProfile(
      {String? phone,
      String? location,
      String? gender,
      String? name,
      String? dob,
      String? about}) async {
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
      "phone": phone,
      "location": location,
      "gender": gender,
      "about": about,
      "dob": dob,
      "name": name,
    };
    try {
      var response = await _dio.patch('/user', data: data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        response.data.putIfAbsent('success', () => true);
        print(response.data);
        return response.data;
      } else {
        response.data.putIfAbsent('success', () => false);
        print(response.data);
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
        Map error = {'success': false, 'message': 'Fail to send try again '};
        return error;
    }
  }
}
