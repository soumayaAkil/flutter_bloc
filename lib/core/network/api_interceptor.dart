
import 'package:dio/dio.dart';

class ApiIntercepter extends Interceptor {
  ApiIntercepter();

}

/*
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer your_access_token';
          return handler.next(options);
        },
        onError: (DioError e, handler) async {
          if (e.response?.statusCode == 401) {

            return handler.resolve(await dio.fetch(e.requestOptions));
          }     else if (e.response?.statusCode == 400) {
            print('00000');
        }
          return handler.next(e);
        },
      ),
    );
    */