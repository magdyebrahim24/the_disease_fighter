// import 'dart:io';
//
// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio/dio.dart';
//
// class BaseUrl {
//   //Configure default request address
//   static String url = 'https://thediseasefighter.herokuapp.com'; // test environment
// }
//
// Dio _dio  = Dio(); // use default configuration
//
// Future getModel() async {
//   //Configure DIO instance
//   _dio.options.baseUrl = BaseUrl.url;
//   _dio.options.connectTimeout = 5000; //5s
//   _dio.options.receiveTimeout = 3000;
//
//
//   Response response;
//   Dio dio = Dio();
//   response = await dio.get("/user");
//   print(response.data.toString());
// //Request parameters can also be passed through objects. The above code is equivalent to:
//   response = await dio.get("/test", queryParameters: {"id": 12, "name": "wendu"});
//   print(response.data.toString());
// }
//
// Future postModel() async {
//   //Configure DIO instance
//   _dio.options.baseUrl = BaseUrl.url;
//   _dio.options.connectTimeout = 5000; //5s
//   _dio.options.receiveTimeout = 3000;
//
//   var response = await _dio.post("/test", data: {"id": 12, "name": "wendu"});
//   try {
//     Response response = await _dio.get("https://www.google.com");
//   print(response.data);
//   print(response.headers);
//   print(response.requestOptions);
//   print(response.statusCode);
//   } on DioError catch (e) {
//   //Catch prompt
//   print ('catch prompt: '+ e.toString());
//   } finally {
//   }
// }
//
//
// class Api {
//   static final CookieJar cookieJar = new CookieJar();
//
// }
//
// List<Cookie> cookies = [
//   new Cookie("xxx", xxx),
//   // ....
// ];
// //Save cookies
// Api.cookieJar.saveFromResponse(Uri.parse(BaseUrl.url), cookies);
//
// //Get cookies
// List<Cookie> cookies = Api.cookieJar.loadForRequest(Uri.parse(BaseUrl.url));
// // print(cookies);
//
// _dio.interceptors.add(CookieManager(await Api.cookieJar));
