import 'package:dio/dio.dart';

class DioUtil{
  void dioGet(String url,dynamic onSuccess,dynamic onError) async{
    Dio dio = Dio();
    dio.interceptor.response.onSuccess = (Response response) {
      // 在返回响应数据之前做一些预处理
      print('请求成功：');
      return response; // continue
    };
    dio.interceptor.response.onError = (DioError e){
      // 当请求失败时做一些预处理
      print('请求失败：'+e.message);
      onError();
      return e;//continue
    };
    dio.options = new Options(connectTimeout:10000,receiveTimeout: 3000,);
    Response response = await dio.get(url);
    if(response.statusCode == 200){
      onSuccess(response.data);
    }else{
      onError();
    }
  }
}