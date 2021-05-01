import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/models/ApiCookies.dart';

class UpdateAvatarController {
  Dio _dio = Dio();

  late PersistCookieJar persistentCookies;

  Future updateAvatar({
    File? file,
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

    String fileName = file!.path.split('/').last;
    FormData formData = FormData.fromMap(
        {"file": await MultipartFile.fromFile(file.path, filename: fileName)});

    Map data = {
      'file': MultipartFile.fromFile(file.path,
          filename: fileName, contentType: MediaType('image', 'png'))
      // 'file': await MultipartFile.fromFile(file.path,
      //     filename: fileName, contentType: MediaType('image', 'png')),
    };

    var formDataa = FormData();
    formDataa.files.add(MapEntry(
        'file', MultipartFile.fromFileSync(file.path, filename: fileName)));

    var response = await _dio.patch(
      '/avatar',
      data: formData,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      print(response.statusCode);
      // response.data.putIfAbsent('success', () => true);

      return response.data;
    } else {
      // throw Exception('Failed to Log In');
      print(response.data);
      // response.data.putIfAbsent('success', () => false);

      return response.data;
    }
  }
}
