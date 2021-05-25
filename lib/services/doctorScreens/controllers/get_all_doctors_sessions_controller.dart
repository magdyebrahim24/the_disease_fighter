import 'dart:convert';
import 'dart:core';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/models/ApiCookies.dart';
import 'package:the_disease_fighter/services/doctorScreens/models/get_all_doctors_sessions_model.dart';

class DoctorAppointmentsController {
  Dio _dio = Dio();
  var cookieJar = CookieJar();
  GetAllDoctorsAppointmentsModel _doctorAppointments =
      GetAllDoctorsAppointmentsModel();

  Future _myAppointmentsData() async {
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

    var response = await _dio.get('/sessions');
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      print(response.data);
      return response;
    } else {
      print(response);
      return response;
    }
  }

  Future<GetAllDoctorsAppointmentsModel> getDoctorAppointments() async {
    var jsonString, jsonResponse;
    jsonString = await _myAppointmentsData();
    jsonResponse = json.decode(jsonString.toString());
    _doctorAppointments = GetAllDoctorsAppointmentsModel.fromJson(jsonResponse);
    return _doctorAppointments;
  }
}
