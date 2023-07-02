import 'package:dio/dio.dart';

import 'constants.dart';

class DioHelper{
  static late Dio dio;
  static initDio(){
    
    dio=Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {
          'Content-Type': 'application/json'
        },
        receiveDataWhenStatusError: true,
      ),
    );
  }
  static Future<Response> getData(
      {required String url, Map<String,dynamic>? query,})async{
    return await dio.get(url, queryParameters: query,);
  }

  static Future<Response> postDataDio(
      {required String url,
        required Map<String,dynamic>? data,
        Map<String,dynamic>? query,
      })async{
    return await dio.post(url, data: data,queryParameters: query);
  }
}

