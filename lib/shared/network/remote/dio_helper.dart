import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          // https://newsapi.org/
          receiveDataWhenStatusError: true,
          headers: {'Content-Type': 'application/json', 'lang': 'en'}),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? taken,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': taken


        //  ?? '',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'en',
    String? taken,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': taken??'',
    };
    return dio.post(url, queryParameters: query, data: data);
  }
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'en',
    String? taken,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': taken??'',
    };
    return dio.put(url, queryParameters: query, data: data);
  }
}
