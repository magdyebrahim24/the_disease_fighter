import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/services/base_url/ApiCookies.dart';
import 'package:the_disease_fighter/services/doctors/models/get_one_doctor_model.dart';

class GetOneDoctorController {
  Dio _dio = Dio();
  var cookieJar = CookieJar();
  OneDoctorModel _getOneDoctorModel = OneDoctorModel();

  Future _getOneDoctor({docId}) async {
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

    var response = await _dio.get('/doctors/$docId');
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      print(response.data);
      response.data.putIfAbsent('success', () => true);
      return response;
    } else {
      print(response.data);
      return response;
    }
  }

  Future<OneDoctorModel?> oneDoctorData({docId}) async {
    var jsonString, jsonResponse;
    jsonString = await _getOneDoctor(docId: docId);
    jsonResponse = json.decode(jsonString.toString());
    print(jsonResponse.toString());
    _getOneDoctorModel = OneDoctorModel.fromJson(jsonResponse);
    return _getOneDoctorModel;
  }
}
