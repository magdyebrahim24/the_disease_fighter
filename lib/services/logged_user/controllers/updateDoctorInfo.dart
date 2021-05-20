import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/models/ApiCookies.dart';

class UpdateDoctorInfoController {
  Dio _dio = Dio();

  late PersistCookieJar persistentCookies;

  Future updateDoctorInfo({
    String? phone,
    String? clinicLocation,
    String? gender,
    String? dob,
    String? specId,
    String about = '',
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
      "about": about.toString(),
      "clinic_location": clinicLocation.toString(),
      "dob": dob.toString(),
      "gender": gender.toString(),
      "phone": phone.toString(),
      "spec_id": specId.toString(),
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
      Map error = {'success': false, 'message': 'Fail , check your internet'};
      return error;
    }
  }
}
