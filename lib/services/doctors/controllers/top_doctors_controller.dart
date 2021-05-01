import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/models/ApiCookies.dart';
import 'package:the_disease_fighter/services/doctors/models/top_doctors_model.dart';

class TopDoctorsController {
  Dio _dio = Dio();
  var cookieJar = CookieJar();

  TopDoctorsModel _topDoctorsList = TopDoctorsModel();

  Future _getTopDoctors() async {
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

    var response = await _dio.get('/doctors/top');
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      print(response);
      return response;
    } else {
      print(response);
      return response;
      // throw Exception('Failed to get user data');
    }
  }

  Future<TopDoctorsModel> topDoctorsData() async {
    var jsonString, jsonResponse;
    jsonString = await _getTopDoctors();
    jsonResponse = json.decode(jsonString.toString());
    _topDoctorsList = TopDoctorsModel.fromJson(jsonResponse);
    // print(_favoriteData!.doctors![1].name.toString());
    return _topDoctorsList;
  }
}
