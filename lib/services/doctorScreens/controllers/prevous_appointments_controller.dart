import 'dart:convert';
import 'dart:core';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/services/base_url/ApiCookies.dart';
import 'package:the_disease_fighter/services/doctorScreens/models/previous_appointments_model.dart';
class DoctorPreviousAppointmentsController {
  Dio _dio = Dio();
  var cookieJar = CookieJar();
  PreviousAppointmentsModel _previousAppointmentsModel=PreviousAppointmentsModel();
  Future _previousAppointmentsData() async {
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

    var response = await _dio.get('/sessions/previous');
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      print(response.data);
      return response;
    } else {
      print(response);
      return response
      ;
    }
  }
  Future<PreviousAppointmentsModel>getDoctorPreviousAppointments() async {
    var jsonString, jsonResponse;
    jsonString = await _previousAppointmentsData();
    jsonResponse = json.decode(jsonString.toString());
    _previousAppointmentsModel = PreviousAppointmentsModel.fromJson(jsonResponse);
    return _previousAppointmentsModel ;
  }
}
