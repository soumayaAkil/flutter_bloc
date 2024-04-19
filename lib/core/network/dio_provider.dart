
import 'package:dio/dio.dart';

import '../config/config.dart';
/*
class DioProvider{
  static Dio instance(
      PersistCookieJar cookieJar,
      )=> Dio(
    BaseOptions(
      connectTimeout: timeOutDuration,
    receiveTimeout: connectionTimeDuration,
    ),
  )..interceptors.addAll(
    [
      CookieManager(
        cookieJar,
      ),
      ApiInterceptor(),
      if(!kReleaseMode)
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj)=>("$obj",name:"Dio"),
        ),
    ],
  );
}
*/