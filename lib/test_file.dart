// import 'dart:io';
// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:path_provider/path_provider.dart';
//
// class WebFunctions {
//   final Dio _dio = Dio();
//   late PersistCookieJar persistentCookies;
//   final String URL = "http://test/";
//
//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//     return directory.path;
//   }
//
//   Future<Directory> get _localCoookieDirectory async {
//     final path = await _localPath;
//     final Directory dir = new Directory('$path/cookies');
//     await dir.create();
//     return dir;
//   }
//
//   Future<String?> getCsrftoken() async{
//     try {
//       String csrfTokenValue;
//       final Directory dir = await _localCoookieDirectory;
//       final cookiePath = dir.path;
//       persistentCookies = PersistCookieJar(dir: '$cookiePath');
//       persistentCookies.deleteAll(); //clearing any existing cookies for a fresh start
//       _dio.interceptors.add(
//           CookieManager(persistentCookies) //this sets up _dio to persist cookies throughout subsequent requests
//       );
//       _dio.options = new BaseOptions(
//         baseUrl: URL,
//         // contentType: ContentType.json,
//         responseType: ResponseType.json,
//         connectTimeout: 5000,
//         receiveTimeout: 100000,
//         headers: {
//           HttpHeaders.userAgentHeader: "dio",
//           "Connection": "keep-alive",
//         },
//       ); //BaseOptions will be persisted throughout subsequent requests made with _dio
//       _dio.interceptors.add(
//           InterceptorsWrapper(
//               onResponse:(Response response ) async {
//                 List<Cookie> cookies =[Cookie('cookies',persistentCookies.loadForRequest(Uri.parse(URL)).toString() )] ;
//                 csrfTokenValue = cookies.firstWhere((c) => c.name == 'csrftoken', orElse: () => null).value;
//                 if (csrfTokenValue != null) {
//                   _dio.options.headers['X-CSRF-TOKEN'] = csrfTokenValue; //setting the csrftoken from the response in the headers
//                 }
//                 return response.data;
//               }
//           )
//       );
//       await _dio.get("/accounts/login/");
//       return csrfTokenValue;
//     } catch (error, stacktrace) {
//       print("Exception occured: $error stackTrace: $stacktrace");
//       return null;
//     }
//   }
//
//   getSessionId() async {
//     try {
//       final csrf = await getCsrftoken();
//       FormData formData = new FormData.fromMap({
//         "username": "username",
//         "password": 'A *passphrase* is stronger than a password.',
//         "csrfmiddlewaretoken" : '$csrf'
//       });
//       Options optionData = new Options(
//         contentType: ContentType.parse("application/x-www-form-urlencoded").toString(),
//       );
//       Response response = await _dio.post("/accounts/login/", data: formData, options: optionData);
//       print(response.statusCode);
//     } on DioError catch(e) {
//       if(e.response != null) {
//         print( e.response!.statusCode.toString() + " " + e.response!.statusMessage.toString());
//         print(e.response!.data);
//         print(e.response!.headers);
//         print(e.response!.requestOptions);
//       } else{
//         print(e.requestOptions.toString());
//         print(e.message);
//       }
//     }
//     catch (error, stacktrace) {
//       print("Exception occured: $error stackTrace: $stacktrace");
//       return null;
//     }
//   }
// }
