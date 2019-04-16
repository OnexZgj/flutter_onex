import 'package:dio/dio.dart';

class ApiManager {
  Dio _dio;

  factory ApiManager() => _getInstance();
  static ApiManager _instance;

  ApiManager._internal() {
    var options = BaseOptions(
        baseUrl: "https://www.wanandroid.com/",
        connectTimeout: 20000,
        receiveTimeout: 10000);
    _dio = Dio(options);
  }

  static ApiManager _getInstance() {
    if (_instance == null) {
      _instance = new ApiManager._internal();
    }
    return _instance;
  }

  static ApiManager get instance => _getInstance();

  /// 获取推荐微信公众号
  Future<Response> getWechatCount() async {
    try {
      Response response = await _dio.get("wxarticle/chapters/json");
      return response;
    } catch (e) {
      return null;
    }
  }

  /// 获取微信文章列表
  Future<Response> getWechatArticle(int cid, int page) async {
    try {
      Response response = await _dio.get("wxarticle/list/${cid}/${page}/json");
      return response;
    } catch (e) {
      return null;
    }
  }

  /// 获取项目分类
  Future<Response> getProjectClassify() async {
    try {
      Response response = await _dio.get("project/tree/json");
      return response;
    } catch (e) {
      return null;
    }
  }

  /// 获取项目列表
  Future<Response> getProjectList(int cid, int page) async {
    try {
      Response response = await _dio
          .get("project/list/${page}/json", queryParameters: {"cid": "${cid}"});
      return response;
    } catch (e) {
      return null;
    }
  }

  /// 获取首页Banner
  Future<Response> getHomeBanner() async {
    try {
      Response response = await _dio.get("banner/json");
      return response;
    } catch (e) {
      return null;
    }
  }

  /// 获取首页文章列表
  Future<Response> getHomeArticle(int page) async {
    try {
      Response response = await _dio.get("article/list/${page}/json");
      return response;
    } catch (e) {
      return null;
    }
  }

  ///搜索关键字
  Future<Response> searchArticle(int page,String key) async {
    try {

      FormData formData = new FormData.from({
        "k": "$key",
      });

      Response response = await _dio.post("article/query/${page}/json",data:formData);
      return response;
    } catch (e) {
      return null;
    }
  }
}
