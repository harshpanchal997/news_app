import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class CacheInterceptor extends Interceptor{

  var dio = new Dio();

  String apiType;
  Dio previous;
  BuildContext context;

  CacheInterceptor(this.context, this.previous, this.apiType);


  static String apiPOST = "POST";
  static String apiGET = "GET";
  static String apiGETQUERYPARAMETER = "GETQUERYPARAMETER";
  static String apiPUT = "PUT";
  static String apiPUTQUERYPARAMETER = "PUTQUERYPARAMETER";
  static String apiDELETE = "DELETE";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {

    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioError error, ErrorInterceptorHandler handler) async {
    print("onError Interceptor");
    print("Error Code - ${error.response?.statusCode}");
    print(error);
    if (error.response?.statusCode == 401) {
      // logout(context);

      // RequestOptions options = error.requestOptions;
      //
      // showLog("onError Interceptor Lock request...");
      // // Lock to block the incoming request until the token updated
      // previous.lock();
      // previous.interceptors.responseLock.lock();
      // previous.interceptors.errorLock.lock();
      //
      // try {
      //   await apiRefreshToken();
      //
      //   previous.unlock();
      //   previous.interceptors.responseLock.unlock();
      //   previous.interceptors.errorLock.unlock();
      //   showLog("onError Interceptor Unlock request...");
      //
      //   /*
      //   * -- calling past api with new token and parameters
      //   * */
      //
      //   String accessToken = getUserAccessToken();
      //
      //   var dioauth = Dio(BaseOptions(headers: {
      //     "Authorization": "Bearer " + accessToken,
      //     "content-type": "application/json",
      //   }));
      //
      //   showLog("options.path : ${options.path}");
      //   showLog("options : ${options}");
      //
      //   Response? response;
      //
      //   if (apiType == apiGET) {
      //     response = await dioauth.get(options.path);
      //   } else if (apiType == apiGETQUERYPARAMETER) {
      //     response = await dioauth.get(options.path,
      //         queryParameters: options.queryParameters);
      //   } else if (apiType == apiPOST) {
      //     response = await dioauth.post(options.path, data: options.data);
      //   } else if (apiType == apiPUT) {
      //     response = await dioauth.put(options.path, data: options.data);
      //   } else if (apiType == apiPUTQUERYPARAMETER) {
      //     response = await dioauth.put(options.path,
      //         queryParameters: options.queryParameters);
      //   } else if (apiType == apiDELETE) {
      //     response = await dioauth.delete(options.path);
      //   }
      //
      //   return handler.resolve(response!);
      // } catch (e) {
      //   logout(context);
      // }
    }
    else {
      return handler.resolve(error.response!);
    }
    // return error;

  }

}