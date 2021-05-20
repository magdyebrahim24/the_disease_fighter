import 'dart:convert';
import 'dart:core';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/models/ApiCookies.dart';
import 'package:the_disease_fighter/services/notification/models/show_patient_notification_model.dart';
class ShowPatientNotificationController {
  Dio _dio = Dio();
  var cookieJar = CookieJar();
  ShowtPatientNotificationModel _patientNotificationModel=ShowtPatientNotificationModel();
  Future _showPatientNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _token = prefs.getString('access_token') ?? '';
    _dio.options
      ..baseUrl = BaseUrl.url
      ..connectTimeout = 50000 //5s
      ..receiveTimeout = 50000
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      }
      ..headers = {
        'authorization': 'Bearer ' + _token,
      };

    (await ApiCookies.cookieJar).loadForRequest(Uri.parse(BaseUrl.url));
    _dio.interceptors.add(CookieManager(await ApiCookies.cookieJar));

    var response = await _dio.get('/notifications');
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      print(response.data);
      return response;
    } else {
      response.data.putIfAbsent('sessions', () => []);
      print(response.data);
      return response
      ;
    }
  }
  Future<ShowtPatientNotificationModel>getPatientNotification() async {
    var jsonString, jsonResponse;
    jsonString = await _showPatientNotification();
    jsonResponse = json.decode(jsonString.toString());
    _patientNotificationModel = ShowtPatientNotificationModel.fromJson(jsonResponse);
    return  _patientNotificationModel  ;
  }
}
