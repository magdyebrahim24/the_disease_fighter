import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

class BaseUrl {
  static String url = 'https://thediseasefighter.herokuapp.com';
}

class ApiCookies {
  // static final CookieJar cookieJar = new CookieJar();

  static PersistCookieJar _cookieJar = PersistCookieJar();

  static Future<PersistCookieJar> get cookieJar async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    await appDocDir.create(recursive: true);

    _cookieJar = new PersistCookieJar(
        ignoreExpires: true,
        persistSession: true,
        storage: FileStorage(appDocPath + "/.cookies/"));

    return _cookieJar;
  }
}
