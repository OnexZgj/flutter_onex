import 'package:dio/dio.dart';

class GnakApiManager {
  Dio _dio;

  factory GnakApiManager() => _getInstance();
  static GnakApiManager _instance;

  GnakApiManager._internal() {
    var options = BaseOptions(
        baseUrl: "http://gank.io/api/data/福利/10",
        connectTimeout: 20000,
        receiveTimeout: 10000);
    _dio = Dio(options);
  }

  static GnakApiManager _getInstance() {
    if (_instance == null) {
      _instance = new GnakApiManager._internal();
    }
    return _instance;
  }

  static GnakApiManager get instance => _getInstance();


  /**
   * 获取妹子福利
   */
  Future<Response> getWelfare(int page) async {
    try {
      Response response = await _dio.get("/${page}");
      return response;
    } catch (e) {
      return null;
    }
  }


}
