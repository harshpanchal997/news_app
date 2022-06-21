import 'package:app/utils/apis/cache_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class RestClient {
  static var dio = new Dio();

  /*
  * ----
  * */
  static Future<Response> getData(BuildContext context, String endpoint) async {
    print("-------------------------------------");
    print("API URL - $endpoint");
    print("API Method - GET");
    print("API Request Data -");
    print("-------------------------------------");

    var dioAuth = Dio(BaseOptions(headers: {
      "Accept": "application/json",
    }));

    dioAuth.interceptors.clear();
    dioAuth.interceptors.add(CacheInterceptor(context, dio, CacheInterceptor.apiGET));
    Response response = await dioAuth.get(endpoint);
    print("API Response - ${response.toString()}");
    print("-------------------------------------");
    return response;
  }
}
